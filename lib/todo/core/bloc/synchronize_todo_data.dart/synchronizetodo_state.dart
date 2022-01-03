part of 'synchronizetodo_bloc.dart';

abstract class SynchronizetodoState extends Equatable {
  const SynchronizetodoState();

  @override
  List<Object> get props => [];
}

class SynchronizetodoInitial extends SynchronizetodoState {}

class SynchronizetodoSynchronizing extends SynchronizetodoState {}

class SynchronizetodoDoneSynchronizing extends SynchronizetodoState {}

class SynchronizetodoFailed extends SynchronizetodoState {
  final String message;

  const SynchronizetodoFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class SynchronizetodoSucceeded extends SynchronizetodoState {}
