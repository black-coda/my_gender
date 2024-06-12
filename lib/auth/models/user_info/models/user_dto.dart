// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDTO {
  final String email;
  final String password;
  final String displayName;

  UserDTO({
    required this.email,
    required this.password,
    this.displayName = "",
  });
}

class UserProfileDTO {
  final String displayName;
  final String email;
  final String dob;
  final String photoUrl;

  UserProfileDTO({
    required this.displayName,
    required this.email,
    required this.dob,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'dob': dob,
      'photoUrl': photoUrl,
    };
  }

  factory UserProfileDTO.fromMap(Map<String, dynamic> map) {
    return UserProfileDTO(
      displayName: map['displayName'] as String? ?? '',
      email: map['email'] as String? ?? '' ,
      dob: map['dob']  as String? ?? '',
      photoUrl: map['photoUrl']  as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileDTO.fromJson(String source) =>
      UserProfileDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileDTO(displayName: $displayName, email: $email, dob: $dob, photoUrl: $photoUrl)';
  }
}
