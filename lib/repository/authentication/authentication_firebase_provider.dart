import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFirebaseProvider {
  final FirebaseAuth _firebaseAuth;
  AuthenticationFirebaseProvider({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<User?> getAuthStates() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      throw Exception();
    }
  }

  Future<User?> login({
    required AuthCredential credential,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
