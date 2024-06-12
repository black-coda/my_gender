import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/auth/controllers/is_logged_in_provider.dart';


class UserProfileBackend {
  final Ref ref;

  UserProfileBackend({required this.ref});

  Future<bool> updateUserPassword({required String newPassword}) async {
    final isUserLoggedIn = ref.watch(isLoggedInProvider);
    if (isUserLoggedIn) {
      await ref.watch(firebaseProvider).currentUser?.updatePassword(newPassword);
      return true;
    }
    return false;
  }


  Future<bool> updateUserDisplayName({required String displayName}) async {
    final isUserLoggedIn = ref.watch(isLoggedInProvider);
    if (isUserLoggedIn) {
      await ref
          .watch(firebaseProvider)
          .currentUser
          ?.updateDisplayName(displayName);
      return true;
    }
    return false;
  }
}


final userProfileBackendProvider = Provider<UserProfileBackend>((ref) {
  return UserProfileBackend(ref: ref);
});
