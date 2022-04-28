part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStateChanged extends AuthenticationEvent {
  final AuthenticationModel authenticationModel;

  const AuthenticationStateChanged({required this.authenticationModel});

  @override
  List<Object> get props => [authenticationModel];
}

class AuthenticationGoogleStarted extends AuthenticationEvent {}

class AuthenticationExited extends AuthenticationEvent {}
