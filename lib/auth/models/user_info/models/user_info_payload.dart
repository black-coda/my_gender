import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:my_gender/utils/user_id_typedef.dart';

import '../firebase_field_name.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.email: email ?? " ",
            FirebaseFieldName.displayName: displayName ?? "",
          },
        );
}
