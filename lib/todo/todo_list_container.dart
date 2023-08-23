import 'package:flutter/material.dart';
import 'package:todo_app/todo/todo_header.dart';
import 'todo_list.dart';

class TodoListContainer extends StatefulWidget {
  const TodoListContainer({super.key});

  @override
  State<TodoListContainer> createState() => _TodoListContainerState();
}

class _TodoListContainerState extends State<TodoListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TodoHeader(),
          const Expanded(
            child: TodoList(),
          )
        ],
      ),
    );
  }
}
