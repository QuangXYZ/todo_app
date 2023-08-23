import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

import '../base/base_bloc.dart';
import '../event/add_todo_event.dart';

class TodoHeader extends StatefulWidget {
  const TodoHeader({super.key});

  @override
  State<TodoHeader> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends State<TodoHeader> {
  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(children: <Widget>[
      Expanded(
        child: TextFormField(
          controller: txtTodoController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              labelText: "Add todo",
              hintText: "Add todo"),
        ),
      ),
      SizedBox(
        height: 45.0,
        width: 45.0,
        child: TextButton(
          onPressed: () {
            if (txtTodoController.text.isEmpty) {
              txtTodoController.selection;
              return;
            }
            bloc.event.add(AddTodoEvent(txtTodoController.text));
            txtTodoController.clear();
          },
          child: Icon(Icons.add),
        ),
      )
    ]);
    ;
  }
}
