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
