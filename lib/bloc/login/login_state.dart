part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final User? user;
  final String? message;
  const LoginState({required this.status, this.user, this.message});

  @override
  List<Object> get props => [status, user ?? "", message??""];
}
