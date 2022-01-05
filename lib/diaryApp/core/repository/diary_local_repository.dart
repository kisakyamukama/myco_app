import 'package:myco/diaryApp/core/dao/diary_dao.dart';
import 'package:myco/diaryApp/core/model/model.dart';
import 'package:myco/todo/core/model/todo.dart';

class DiaryLocalRepository {
  final diaryDao = DiaryDao();

  Future getAllJournals({String? query}) =>
      diaryDao.getJournals(query: query, columns: []);

  Future insertTodo(Diary diary) => diaryDao.createDiary(diary);

  Future updateTodo(Todo todo) => diaryDao.updateTodo(todo);

  Future deleteTodoById(int id) => diaryDao.deleteTodo(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() => diaryDao.deleteAllTodos();

   Future synchronizeTodos() => diaryDao.synchronize();
}
