import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco/todo/core/repository/todo_do_repository.dart';

part 'synchronizetodo_event.dart';
part 'synchronizetodo_state.dart';

class SynchronizetodoBloc
    extends Bloc<SynchronizetodoEvent, SynchronizetodoState> {
  SynchronizetodoBloc() : super(SynchronizetodoInitial()) {
    on<SynchronizetodoEvent>(_mapSyncEventToState);
  }

  Future<void> _mapSyncEventToState(
      SynchronizetodoEvent event, Emitter<SynchronizetodoState> emit) async {
    if (event is StartTodoSynchronization) {
      emit(SynchronizetodoSynchronizing());
      try {
        TodoRepository _todoRepository = TodoRepository();
        await _todoRepository.synchronizeTodos();
      } catch (e) {
        emit(SynchronizetodoFailed(message: e.toString()));
      }
    }
  }
}
