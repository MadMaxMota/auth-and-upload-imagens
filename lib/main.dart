import 'package:authetication_with_google/bloc/authetication/authentication_bloc.dart';
import 'package:authetication_with_google/bloc/image_picker/image_picker_bloc.dart';
import 'package:authetication_with_google/repository/authentication/authentication_firebase_provider.dart';
import 'package:authetication_with_google/repository/authentication/google_sig_in_provider.dart';
import 'package:authetication_with_google/repository/authentication/repository.dart';
import 'package:authetication_with_google/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authenticationRepository: AuthenticationRepository(
              authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                firebaseAuth: FirebaseAuth.instance,
              ),
              googleSignInProvider: GoogleSignInProvider(
                googleSignIn: GoogleSignIn(),
              ),
            ),
          ),
        ),
        BlocProvider<ImagesPickerBloc>(
          create: (context) => ImagesPickerBloc(
            AuthenticationRepository(authenticationFirebaseProvider:  AuthenticationFirebaseProvider(
                firebaseAuth: FirebaseAuth.instance,
              ),googleSignInProvider: GoogleSignInProvider(
                googleSignIn: GoogleSignIn(),
              ),),
            storage: _storage,
          
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeMainView(),
      ),
    );
  }
}
