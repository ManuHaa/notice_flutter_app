import 'package:flutter/material.dart';
import 'package:notice_flutter_app/db/todo_database.dart';
import 'package:notice_flutter_app/model/todo.dart';

import 'todos_edit_page.dart';

class TodoDetailPage extends StatefulWidget {
  final int todoId;

  const TodoDetailPage({
    Key? key,
    required this.todoId,
  }) : super(key: key);

  @override
  _TodoDetailPageState createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  late Todo todo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshTodo();
  }

  //aktualisiert in DB
  Future refreshTodo() async {
    setState(() => isLoading = true);

    this.todo = await TodoDatabase.instance.readNote(widget.todoId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: new Text('Todos', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [deleteButton(), editButton()],
        ),
        body: isLoading
            ? Center()
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    Text(
                      todo.description,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: Colors.white,
      ),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditTodoPage(todo: todo),
        ));

        refreshTodo();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          await TodoDatabase.instance.delete(widget.todoId);

          Navigator.of(context).pop();
        },
      );
}
