import '../base/base_event.dart';
import '../model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  Todo? todo;
  DeleteTodoEvent(this.todo);
}
