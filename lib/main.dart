import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/firebase_options.dart';
import 'package:my_gender/router/route_manager.dart';
import 'package:my_gender/utils/loading/loading_screen_widget.dart';
import 'package:my_gender/utils/theme/service/theme_setting_service.dart';

import 'auth/controllers/is_loading_provider.dart';
import 'notification/service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().init();
  runApp(
    const ProviderScope(
      child: AppEntry(),
    ),
  );
}

class AppStartUpWidget extends ConsumerWidget {
  const AppStartUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startUpState = ref.watch(loadingSettingsFutureProvider);
    return startUpState.when(
      data: (_) => const AppEntry(),
      loading: () => const AppStartUpLoadingScreen(),
      error: (Object error, StackTrace stackTrace) => AppStartUpErrorScreen(
        errorMessage: error.toString(),
      ),
    );
  }
}

class AppStartUpLoadingScreen extends ConsumerWidget {
  const AppStartUpLoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class AppStartUpErrorScreen extends StatelessWidget {
  const AppStartUpErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(child: Text(errorMessage)),
    ));
  }
}

class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        ref.listen<bool>(
          isLoadingProvider,
          (_, isLoading) {
            if (isLoading) {
              LoadingScreenWidget.instance().show(context: context);
            } else {
              log("is loading not ...");
              LoadingScreenWidget.instance().hide();
            }
          },
        );
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: ref.watch(settingsServiceProvider).themeMode,
          routerConfig: ref.watch(routerProvider),
          theme: ThemeData(
            colorSchemeSeed: ref.watch(settingsServiceProvider).materialColor,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: ref.watch(settingsServiceProvider).materialColor,
            brightness: Brightness.dark,
          ),
        );
      },
    );
  }
}
