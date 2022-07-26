import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tictactoe/data/models/auth.dart';

class AuthRepository extends ChangeNotifier {
  late final firebase_auth.FirebaseAuth _auth;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = AuthModel.empty;

  Stream<AuthModel> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AuthModel.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  // Method for new user to sign in using Google account
  Future<void> signInWithGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final firebase_auth.OAuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (_) {}
  }

  Future<void> logout() async {
    try {
      await Future.wait([_auth.signOut()]);
    } catch (_) {}
  }
}

extension on firebase_auth.User {
  AuthModel get toUser {
    return AuthModel(
      uid: uid,
      email: email,
    );
  }
}
