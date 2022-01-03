part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmittedEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmittedEvent({required this.username, required this.password});
}

class CheckIfuserLoggedIn extends LoginEvent {}
