import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco/bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  initState() {
    checkIfUserIsLoggedIn();
    super.initState();
  }

  checkIfUserIsLoggedIn() {
    context.read<LoginBloc>().add(CheckIfuserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loading) {
          debugPrint('well loading');
        } else if (state.status == LoginStatus.success) {
          debugPrint('well success');
          Navigator.pushReplacementNamed(context, 'myco');
        } else if (state.status == LoginStatus.failure) {
          debugPrint('well failure');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Welcome to Myco App',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginSubmittedEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ));
                    },
                    child: const Text('Login'))
              ],
            ));
      }),
    )
        // )
        );
  }

  Future submit(BuildContext context) async {
    // validate

    // sign in
    if (_usernameController.text != null && _passwordController.text != null) {
      LoginBloc loginBloc = BlocProvider.of(context);
      loginBloc.add(LoginSubmittedEvent(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim()));
    } else {
      debugPrint('Username and password are not provided');
    }
  }
}
