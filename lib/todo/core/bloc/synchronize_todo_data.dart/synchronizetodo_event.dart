part of 'synchronizetodo_bloc.dart';

abstract class SynchronizetodoEvent extends Equatable {
  const SynchronizetodoEvent();

  @override
  List<Object> get props => [];
}

class StartTodoSynchronization extends SynchronizetodoEvent {}
