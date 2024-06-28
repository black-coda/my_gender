import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/models/auth_result.dart';
import 'package:my_gender/auth/models/auth_state.dart';
import 'package:my_gender/auth/models/user_info/backend/user_info.dart';
import 'package:my_gender/utils/user_id_typedef.dart';

import '../backend/authenticator.dart';
import '../models/user_info/models/user_dto.dart';
import '../view/login/login_view.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle(context) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle(context);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> loginWithEmailAndPassword(UserDTO userDTO, context) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.loginWithEmailAndPassword(userDTO, context);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

// sign up
  Future<void> signUpWithEmailAndPassword(UserDTO userDTO, context) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.signUpWithEmailAndPassword(userDTO, context);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User created successfully! Please login to continue."),
        ),
      );
      state = const AuthState.unknown();
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
        
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
