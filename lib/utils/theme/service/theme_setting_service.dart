import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

class ThemeKonstant {
  static const String themeString = "themeString";
  static const String themeMode = "themeMode";

  static const Map<String, MaterialColor> colorTheme = {
    'green': Colors.green,
    'red': Colors.red,
    'purple': Colors.purple,
    'orange': Colors.orange,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
  };
}

class SettingState {
  final MaterialColor materialColor;
  final bool isLoading;
  final ThemeMode themeMode;

  SettingState(
      {required this.materialColor,
      required this.isLoading,
      required this.themeMode});

  SettingState copyWith(
      {MaterialColor? materialColor, bool? isLoading, ThemeMode? themeMode}) {
    return SettingState(
      materialColor: materialColor ?? this.materialColor,
      isLoading: isLoading ?? this.isLoading,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  const SettingState.defaultState()
      : materialColor = Colors.pink,
        themeMode = ThemeMode.system,
        isLoading = false;
}

class Settings {
  final Ref ref;
  MaterialColor? _color;
  ThemeMode? _themeMode;

  MaterialColor? get color => _color;
  ThemeMode? get themeMode => _themeMode;

  Settings({required this.ref});

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final sharedPref = await ref.watch(sharedPrefProvider.future);
    await sharedPref.setString(ThemeKonstant.themeMode, themeMode.toString());
  }

  Future<void> getThemeMode() async {
    final sharedPref = await ref.watch(sharedPrefProvider.future);
    final themeMode = sharedPref.getString(ThemeKonstant.themeMode);
    if (themeMode != null) {
      _themeMode = getThemeModeFromString(themeMode);
    }
  }

  ThemeMode getThemeModeFromString(String e) {
    return switch (e) {
      "ThemeMode.dark" => ThemeMode.dark,
      "ThemeMode.light" => ThemeMode.light,
      "ThemeMode.system" => ThemeMode.system,
      _ => ThemeMode.system
    };
  }

  Future<MaterialColor?> getSettingState() async {
    final sharedPref = await ref.watch(sharedPrefProvider.future);

    final colorName = sharedPref.getString(ThemeKonstant.themeString);
    if (colorName != null) {
      _color = getThemeStringFromPref(colorName);
      return _color;
    }
    return null;
  }

  MaterialColor? getThemeStringFromPref(String e) {
    return switch (e) {
      "blue" => Colors.blue,
      "green" => Colors.green,
      "red" => Colors.red,
      "orange" => Colors.orange,
      "purple" => Colors.purple,
      "yellow" => Colors.yellow,
      "pink" => Colors.pink,
      "b" => Colors.blueGrey,
      _ => null
    };
  }

  String materialColorToString(MaterialColor e) {
    return switch (e) {
      Colors.blue => "blue",
      Colors.green => "green",
      Colors.red => "red",
      Colors.orange => "orange",
      Colors.pink => "pink",
      Colors.purple => "purple",
      Colors.yellow => "yellow",
      _ => "null"
    };
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeColor(MaterialColor color) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    // final pref = ref.watch()
    final pref = await ref.watch(sharedPrefProvider.future);

    await pref.setString(
        ThemeKonstant.themeString, materialColorToString(color));

    log("saved");
  }
}

class SettingServiceNotifier extends StateNotifier<SettingState> {
  SettingServiceNotifier(this._settings)
      : super(const SettingState.defaultState());

  final Settings _settings;

  Future<void> loadSettings() async {
    // state = state.copyWith(isLoading: true);
    final color = await _settings.getSettingState();
    state = state.copyWith(materialColor: color, isLoading: false);
  }

  Future<void> modifyThemeColor(MaterialColor color) async {
    state = state.copyWith(isLoading: true);

    //! if (_settings.color == null) return;
    log(state.materialColor.toString(), name: "state.materialColor");
    log(color.toString(), name: "color");
    log("${state.materialColor == color}");
    // if (state.materialColor == _settings.color) return;
    state = state.copyWith(materialColor: color);
    state = state.copyWith(isLoading: false);
    log("done");
    await _settings.updateThemeColor(color);
  }

  Future<void> modifyThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(isLoading: true);
    state = state.copyWith(themeMode: themeMode);
    state = state.copyWith(isLoading: false);
    await _settings.setThemeMode(themeMode);
  }
}

// isLoading

final isThemeLoadingProvider = Provider<bool>((ref) {
  final settings = ref.watch(settingsServiceProvider);
  return settings.isLoading;
});

final settingsServiceProvider =
    StateNotifierProvider<SettingServiceNotifier, SettingState>((ref) {
  final settings = ref.watch(settingsProvider);
  return SettingServiceNotifier(settings);
});

final settingsProvider = Provider<Settings>((ref) {
  return Settings(ref: ref);
});

final loadingSettingsFutureProvider = FutureProvider((ref) async {
  await ref.watch(settingsServiceProvider.notifier).loadSettings();
  return;
});
