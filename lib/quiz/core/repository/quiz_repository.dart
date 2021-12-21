import 'package:myco/quiz/core/repository/repository.dart';

class QuizRepository {
  static Future getQuiz() async {
    return await  Repository.fetchQuizQuestions();
  }
}
