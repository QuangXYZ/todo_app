import 'dart:async';
import 'dart:math';

import 'package:todo_app/base/base_bloc.dart';
import 'package:todo_app/base/base_event.dart';
import 'package:todo_app/db/todo_database.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/event/add_todo_event.dart';
import 'package:todo_app/event/delete_todo_event.dart';

import '../db/todo_table.dart';

class TodoBloc extends BaseBloc {
  StreamController<List<Todo>> eventController = StreamController<List<Todo>>();
  List<Todo> _listData = [];
  TodoTable todoTable = TodoTable();

  init() async {
    _listData = await todoTable.selectAllTodo();
    if (_listData.isNotEmpty) {
      eventController.sink.add(_listData);
    } else {
      _listData = [];
    }
  }

  _addTodo(Todo todo) async {
    await todoTable.insertTodo(todo);
    _listData.insert(0, todo);
.    eventController.sink.add(_listData);
  }

  _deleteTodo(Todo? todo) async {
    await todoTable.deleteTodo(todo!);
    _listData.remove(todo);
    eventController.sink.add(_listData);
  }

  @override
  void dispatchEvent(BaseEvent baseEvent) {
    if (baseEvent is AddTodoEvent) {
      var random = Random();
      _addTodo(Todo.fromData(random.nextInt(1000000), baseEvent.context));
    } else if (baseEvent is DeleteTodoEvent) {
      _deleteTodo(baseEvent.todo);
    }
  }

  @override
  dispose() {
    return super.dispose();
  }
}
