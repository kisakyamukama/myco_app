import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco/bloc/network/network_bloc.dart';
import 'package:myco/quiz/bloc/quiz_bloc.dart';
import 'package:myco/router.dart';
import 'package:myco/todo/core/bloc/synchronize_todo_data.dart/synchronizetodo_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(App(
      connectivity: Connectivity(),
    )),
    blocObserver: AppBlocObserver(),
  );
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) debugPrint(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }
}

class App extends StatelessWidget {
  App({Key? key, required this.connectivity}) : super(key: key);
  final Connectivity connectivity;
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(
          create: (context) => QuizBloc(),
        ),
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc(connectivity: connectivity),
        ),

          BlocProvider<SynchronizetodoBloc>(
          create: (context) => SynchronizetodoBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Myco',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: _appRouter.onGeneratedRoute,
      ),
    );
  }
}
