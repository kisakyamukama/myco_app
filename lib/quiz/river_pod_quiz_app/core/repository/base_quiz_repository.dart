import 'package:myco/quiz/core/model/model.dart';
import 'package:myco/quiz/river_pod_quiz_app/constants/enums.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions({
    int numQuestions,
    int categoryId,
    Difficulty difficulty,
  });
}