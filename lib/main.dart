import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco/quiz/bloc/quiz_bloc.dart';
import 'package:myco/quiz/ui/quiz_app.dart';
import 'package:myco/todo/todo_app.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const App()),
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
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(
          create: (context) => QuizBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Myco',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Myco(),
      ),
    );
  }
}

class Myco extends StatefulWidget {
  const Myco({Key? key}) : super(key: key);

  @override
  State<Myco> createState() => _MycoState();
}

class _MycoState extends State<Myco> {
  List<Concept> concepts = [
    Concept('Quiz App', (context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const QuizApp()));
    }),
    Concept('Todo App', (context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const TodoApp()));
    })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc ')),
      body: Column(
        children: [
          const Text('Myco'),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: concepts.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => concepts[index].onTap(context),
                    child: Card(
                      color: Colors.amber,
                      child: Center(child: Text(concepts[index].conceptName)),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class Concept {
  final String conceptName;
  final Function onTap;

  Concept(this.conceptName, this.onTap);
}
