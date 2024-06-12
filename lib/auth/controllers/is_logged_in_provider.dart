import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/backend/authenticator.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';

import '../models/auth_result.dart';
import 'auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final currentAuthState = ref.watch(authStateProvider);
  final isAlreadyLoggedIn = ref.watch(firebaseProvider).currentUser != null;
  return currentAuthState.result == AuthResult.success || isAlreadyLoggedIn;
});

final authenticatorProvider = Provider<Authenticator>((ref) {
  return const Authenticator();
});
