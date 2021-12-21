part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent extends Equatable {
  const QuizEvent();
}

class FetchQuizQuestions extends QuizEvent {
  @override
  List<Object?> get props => [];
  
}
