import '../base/base_event.dart';

class AddTodoEvent extends BaseEvent {
  String? context;

  AddTodoEvent(this.context);
}
