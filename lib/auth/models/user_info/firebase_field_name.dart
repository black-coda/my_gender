import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const postId = "post_id";
  static const comment = "comment";
  static const createdAt = "created_at";
  static const date = "date";
  static const displayName = "displayName";
  static const email = "email";
  static const photoUrl = "photoUrl";

  //? Private class
  const FirebaseFieldName._();
}
