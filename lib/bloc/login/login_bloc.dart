import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:myco/auth/user_session.dart';
import 'package:myco/core/model/user.dart';
import 'package:myco/core/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(status: LoginStatus.initial)) {
    on<LoginEvent>(_handleLoginEvent);
  }

  Future<void> _handleLoginEvent(
      LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginSubmittedEvent) {
      emit(const LoginState(status: LoginStatus.loading));
      emit(await _mapEventToState(event));
    }

    if (event is CheckIfuserLoggedIn) {
      var loggedUser = UserSession.instance.getSession();

      if (loggedUser != null) {
        User user = User.fromJson(loggedUser);
        emit(LoginState(status: LoginStatus.success, user: user));
      } else {
        emit(const LoginState(status: LoginStatus.initial));
      }
    }
  }

  Future<LoginState> _mapEventToState(LoginSubmittedEvent event) async {
    try {
      Response response = await AuthRepository.login(
          username: event.username, password: event.password);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var userLoginJson = jsonDecode(response.body);
        UserSession.instance.saveSession(userLoginJson);
        User user = User.fromJson(userLoginJson);
        return LoginState(status: LoginStatus.success, user: user);
      }
      return const LoginState(
          status: LoginStatus.failure, message: 'Wrong user name or password');
    } catch (e) {
      debugPrint(e.toString());
      return const LoginState(status: LoginStatus.failure, message: 'Error: ');
    }
  }
}
