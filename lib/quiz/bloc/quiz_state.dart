part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizFetched extends QuizState {
  final List<Question> questions;

  QuizFetched({required this.questions});

  @override
  List<Object> get props => [questions];
}

class QuizFetchFailed extends QuizState {
  final String message;

  QuizFetchFailed({required this.message});

  @override
  List<Object> get props => [message];
}
