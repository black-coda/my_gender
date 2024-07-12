import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/models/auth_state.dart';

import '../notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
