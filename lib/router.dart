import 'package:flutter/material.dart';
import 'package:myco/apps.dart';
import 'package:myco/quiz/ui/quiz_app.dart';
import 'package:myco/todo/todo_app.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Myco());
        break;
      case 'quizApp':
        return MaterialPageRoute(builder: (_) => const QuizApp());
        break;

      case 'todoApp':
        return MaterialPageRoute(builder: (_) => TodoApp());
        break;

      default:
        return MaterialPageRoute(builder: (_) => const Myco());
        break;
    }
  }
}
