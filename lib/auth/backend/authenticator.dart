// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_gender/auth/constants/constants.dart';
import 'package:my_gender/auth/models/user_info/models/user_dto.dart';
import 'package:my_gender/utils/user_id_typedef.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/auth_result.dart';

class Authenticator {
  const Authenticator();
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? "";

  String? get email => FirebaseAuth.instance.currentUser?.email;

  //* Logout Functionality
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  //*Login Functionality

  // email and password login
  // 77773389482513178

  Future<AuthResult> loginWithEmailAndPassword(UserDTO userDTO) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userDTO.email, password: userDTO.password);
      return AuthResult.success;
    } catch (e) {
      log(e.toString());
      return AuthResult.failure;
    }
  }

  // sign up
  Future<AuthResult> signUpWithEmailAndPassword(UserDTO userDTO) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userDTO.email, password: userDTO.password);
      return AuthResult.success;
    } catch (e) {
      log(e.toString());
      return AuthResult.failure;
    }
  }

  //? Login with google credential

  Future<AuthResult> loginWithGoogle() async {
    //?   Creates a GoogleSignIn object with the email scope.

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      AuthKonstant.emailScope,
    ]);

    //?   Waits for the user to sign in with their Google account.
    final signInAccount = await googleSignIn.signIn();

    //?   If the sign-in process is canceled, returns an AuthResult object with a value of aborted.
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    //? Gets the authentication data from the signed-in Google account.
    //? which will retrieve the authentication token after sign in.
    final googleAuth = await signInAccount.authentication;

    //? Uses the GoogleAuthProvider.credential method to create a OAuthCredential
    //? object
    //? with the access token and ID token from the authentication data.
    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //? Uses the signInWithCredential method from the FirebaseAuth class to sign
    //? in the user with the OAuth credential.
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  //?
}
