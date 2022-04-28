import 'package:authetication_with_google/model/psychologist_model.dart';
import 'package:authetication_with_google/repository/authentication/google_sig_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_firebase_provider.dart';

class AuthenticationRepository {
  final AuthenticationFirebaseProvider _authenticationFirebaseProvider;
  final GoogleSignInProvider _googleSignInProvider;

  AuthenticationRepository({
    required AuthenticationFirebaseProvider authenticationFirebaseProvider,
    required GoogleSignInProvider googleSignInProvider,
  })  : _googleSignInProvider = googleSignInProvider,
        _authenticationFirebaseProvider = authenticationFirebaseProvider;

  Future<AuthenticationModel> getAuthDetailStream() async {
    return _getAuthCredentialFromFirebaseUser(user: await _authenticationFirebaseProvider.getAuthStates());
  }

  Future<AuthenticationModel> authenticateWithGoogle() async {
    User? user = await _authenticationFirebaseProvider.login(
      credential: await _googleSignInProvider.login(),
    );
    return _getAuthCredentialFromFirebaseUser(user: user);
  }

  Future<void> unAuthenticate() async {
    await _googleSignInProvider.logout();
    await _authenticationFirebaseProvider.logout();
  }

  AuthenticationModel _getAuthCredentialFromFirebaseUser(
      {required User? user}) {
    AuthenticationModel authDetail;
    if (user != null) {
      authDetail = AuthenticationModel(
        isValid: true,
        uid: user.uid,
        email: user.email,
        photoUrl: user.photoURL,
        name: user.displayName,
      );
    } else {
      authDetail = AuthenticationModel(isValid: false, uid: '');
    }
    return authDetail;
  }
}

// class AuthenticationRepository {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationRepository() : _firebaseAuth = FirebaseAuth.instance;

//   Future<FirebaseUser> getUser() async {
//     if (_currentUser != null) return _currentUser;
//     try {
//       final GoogleSignInAccount googleSignInAccount =
//           await googleSignIn.signIn();
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken,
//       );

//       final AuthResult authResult =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       final FirebaseUser user = authResult.user;
//       return user;
//     } catch (error) {
//       return null;
//     }
//   }

//   Future<void> signInWithCredentials(String email, String password) {
//     return _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//   }

//   Future<void> signUp(String email, String password) async {
//     return await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   Future<void> signOut() async {
//     return Future.wait([_firebaseAuth.signOut()]);
//   }

//   Future<bool> isSignedIn() async {
//     final currentUser = await _firebaseAuth.currentUser();
//     return currentUser != null;
//   }

//   Future<FirebaseUser> getUser() async {
//     return await _firebaseAuth.currentUser();
//   }
// }
