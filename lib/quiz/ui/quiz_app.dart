import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco/quiz/bloc/quiz_bloc.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz app')),
        body: Column(
          children: [
            BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                return Text(state.runtimeType.toString());
              },
            )
          ],
        ));
  }
}
