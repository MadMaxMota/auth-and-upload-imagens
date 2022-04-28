import 'dart:async';

import 'package:authetication_with_google/core/failures.dart';
import 'package:authetication_with_google/model/psychologist_model.dart';
import 'package:authetication_with_google/repository/authentication/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

String? uidGlobal;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      try {
        yield AuthenticationLoading();

        final userData = await _authenticationRepository.getAuthDetailStream();

        add(AuthenticationStateChanged(authenticationModel: userData));
        uidGlobal = userData.uid;
      } catch (error) {
        print(
            'Error occured while fetching authentication detail : ${error.toString()}');
        yield const AuthenticationFailiure(
            message: 'Error occrued while fetching auth detail');
      }
    } else if (event is AuthenticationStateChanged) {
      if (event.authenticationModel.isValid!) {
        yield AuthenticationSuccess(
          authenticationModel: event.authenticationModel,
        );
      } else {
        yield const AuthenticationFailiure(message: 'User has logged out');
      }
    } else if (event is AuthenticationGoogleStarted) {
      try {
        yield AuthenticationLoading();
        AuthenticationModel authenticationDetail =
            await _authenticationRepository.authenticateWithGoogle();

        if (authenticationDetail.isValid!) {
          yield AuthenticationSuccess(
              authenticationModel: authenticationDetail);
        } else {
          yield const AuthenticationFailiure(message: 'User detail not found.');
        }
      } catch (error) {
        if(error is NetworkException){
          emit(AuthenticationNetworkFailure());
        } else {
        yield const AuthenticationFailiure(
            message: 'Unable to login with Google. Try again.');
        }
      }
    } else if (event is AuthenticationExited) {
      try {
        yield AuthenticationLoading();
        await _authenticationRepository.unAuthenticate();
      } catch (error) {
        print('Error occured while logging out. : ${error.toString()}');
        yield const AuthenticationFailiure(
            message: 'Unable to logout. Please try again.');
      }
    }
  }
}

