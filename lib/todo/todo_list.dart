import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/base_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../event/delete_todo_event.dart';
import '../model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _todoListState();
}

class _todoListState extends State<TodoList> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<TodoBloc>(context);
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
        builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
              stream: bloc.eventController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(2),
                          title: Text(snapshot.data![index].content),
                          trailing: GestureDetector(
                            onTap: () {
                              bloc.event
                                  .add(DeleteTodoEvent(snapshot.data![index]));
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: Text(
                        "Empty",
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    );
                  case ConnectionState.none:

                  default:
                    return const Center(
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          )),
                    );
                }
              },
            ));
  }
}
