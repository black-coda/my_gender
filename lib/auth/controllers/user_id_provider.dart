import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/utils/user_id_typedef.dart';

import 'auth_state_provider.dart';

final userIdProvider = Provider<UserId?>((ref) {
  //? This will be returning a type of UserId? which is basically still a String
  return ref.watch(authStateProvider).userId;
});
