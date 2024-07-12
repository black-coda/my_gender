import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/auth/controllers/is_logged_in_provider.dart';
import 'package:my_gender/auth/models/user_info/firebase_field_name.dart';
import 'package:my_gender/auth/models/user_info/models/user_dto.dart';

class UserProfileBackend {
  final Ref ref;

  UserProfileBackend({required this.ref});

  Future<UserProfileDTO?> getUserProfile(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();
      if (doc.docs.isNotEmpty) {
        return UserProfileDTO.fromMap(doc.docs.first.data());
      } else {
        // Handle the case when the document does not exist
        log('User not found');
        return null;
      }
    } catch (e) {
      // Handle any errors
      log('Error getting user data: $e');
      return null;
    }
  }

  Future<bool> updateUserPassword({required String newPassword}) async {
    final isUserLoggedIn = ref.watch(isLoggedInProvider);
    if (isUserLoggedIn) {
      await ref
          .watch(firebaseProvider)
          .currentUser
          ?.updatePassword(newPassword);
      return true;
    }
    return false;
  }

  Future<bool> updateUserProfile(UserProfileDTO userProfileDTO) async {
    User? user = ref.watch(firebaseProvider).currentUser;

    if (user != null) {
      final getPhotoUrl = user.photoURL;
      // Update profile in Firebase Authentication
      await user.updateDisplayName(userProfileDTO.displayName);
      await user.updatePhotoURL(userProfileDTO.photoUrl);

      // Update additional fields in Firestore
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

         
      await userDoc.set(
        userProfileDTO.toMap(),
       SetOptions(merge: true));
      return true;
    }
    return false;
  }
}

final userProfileBackendProvider = Provider<UserProfileBackend>((ref) {
  return UserProfileBackend(ref: ref);
});

final getUserDataProvider = FutureProvider<UserProfileDTO?>((ref) async {
  final UserProfileBackend userProfileBackend =
      ref.read(userProfileBackendProvider);
  final userId = ref.watch(firebaseProvider).currentUser!.uid;

  return userProfileBackend.getUserProfile(userId);
});
