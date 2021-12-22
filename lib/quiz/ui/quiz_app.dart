import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco/quiz/bloc/quiz_bloc.dart';
import 'package:myco/quiz/components/snackbar_component.dart';
import 'package:myco/quiz/core/model/model.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final QuizBloc quizBloc = QuizBloc();
  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>().add(FetchQuizQuestions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz app')),
        body: Column(
          children: [
            BlocListener<QuizBloc, QuizState>(
                listener: (context, state) {
                  if (state is QuizLoading) {
                    mycoSnackBar(context, 'Loading question');
                  } else if (state is QuizFetchFailed) {
                    mycoSnackBar(context, state.message);
                  }
                },
                child: Container()),
            BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if (state is QuizFetched) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.questions.length,
                      itemBuilder: (context, int index) {
                        return MycoQuestionWidget(question:state.questions[index]);
                      },
                    ),
                  );
                } else if (state is QuizFetchFailed) {
                  return Text(state.message);
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 38.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            )
          ],
        ));
  }
}

class MycoQuestionWidget extends StatelessWidget {
  final Question question;
  const MycoQuestionWidget({
    Key? key, required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(question.question),
    );
  }
}
