import 'package:flutter/material.dart';
import 'package:myco/apps.dart';
import 'package:myco/auth/login.dart';
import 'package:myco/devotion/devotion_app.dart';
import 'package:myco/quiz/ui/quiz_app.dart';
import 'package:myco/todo/todo_app.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
        break;
      case 'myco':
        return MaterialPageRoute(builder: (_) => const Myco());
        break;
      case 'quizApp':
        return MaterialPageRoute(builder: (_) => const QuizApp());
        break;

      case 'todoApp':
        return MaterialPageRoute(builder: (_) => TodoApp());
        break;

      case 'devotionApp':
        return MaterialPageRoute(builder: (_) => const DevotionApp());
        break;
      case 'financialTrackerApp':
         return MaterialPageRoute(builder: (_) => const DevotionApp());
        break;

      default:
        return MaterialPageRoute(builder: (_) => const Myco());
        break;
    }
  }
}
