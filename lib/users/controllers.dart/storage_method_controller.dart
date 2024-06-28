import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadPhotoToFirestore(
      File imageFile, String profileName) async {
    try {
      // Get the current user ID
      String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        return null;
      }

      // Create a reference to the location where you want to upload the image
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('profiles')
          .child(userId)
          .child(profileName)
          .child('photo.jpg');

      // Upload the image to Firebase Storage
      TaskSnapshot uploadTask = await ref.putFile(imageFile);

      // Get the download URL of the uploaded image
      String downloadURL = await uploadTask.ref.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (e) {
      log('Error uploading photo: $e');
      return null;
    }
  }
}
