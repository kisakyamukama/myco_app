import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:myco/quiz/core/model/model.dart';
import 'package:myco/quiz/core/repository/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<QuizEvent>(_mapQuizState);
  }

  Future<void> _mapQuizState(QuizEvent event, Emitter<QuizState> emit) async {
    if (event is FetchQuizQuestions) {
      emit(QuizLoading());
      emit(await _mapQuizFetchingStates(event));
    }
  }

  Future<QuizState> _mapQuizFetchingStates(FetchQuizQuestions event) async {
    try {
      Response response = await QuizRepository.getQuiz();
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body)['results'];
        // debugPrint('$json');
        List<Question> _questions =
            json.map((map) => Question.fromJson(map)).cast<Question>().toList();

        return QuizFetched(questions: _questions);
      } else {
        return QuizFetchFailed(message: response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      return QuizFetchFailed(message: e.toString());
    }
  }
}
