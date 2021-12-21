import 'package:http/http.dart' as http;
import 'package:myco/quiz/constants/constants.dart';

class Repository {
static  String uri = quizUrl;
  static Future fetchQuizQuestions() async {
    return await  http.get(Uri.parse(uri));
  }
}
