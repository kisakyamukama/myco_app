import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myco/quiz/river_pod_quiz_app/ui/quiz_app.dart';

class MyQuizApp extends StatelessWidget {
  const MyQuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Riverpod Quiz',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
        ),
        home:const Quiz(),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  const Quiz({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: QuizScreen(),
      
    );
  }
}