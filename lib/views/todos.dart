import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';
import 'package:notice_flutter_app/colorpalette/colorpalette.dart';
import 'package:notice_flutter_app/db/todo_database.dart';
import 'package:notice_flutter_app/model/todo.dart';
import 'package:notice_flutter_app/widgets/todo_card_widget.dart';
import 'todos_edit_page.dart';
import 'todos_detail_page.dart';

//StatelessWidget -> sind nicht veränderbar
//ist der Balken oben
class ToDo extends StatelessWidget {
  static const String routeName = '/to-do';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: Text('To-Dos', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white)),
        drawer: NavDrawer(),
        body: ToDoList(),
      ),
    );
  }
}

//statefulwidget sind veränderbar!!
//body der Seite
class ToDoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<ToDoList> {
  late List<Todo> todos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshTodo();
  }

  //close the DB
  @override
  void dispose() {
    TodoDatabase.instance.close();
    super.dispose();
  }

  //refresh the db
  Future refreshTodo() async {
    setState(() => isLoading = true);
    this.todos = await TodoDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : todos.isEmpty
                  ? Text(
                      'No ToDos',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : buildTodo(),
        ),
        //Butten zum hinzufügen
        floatingActionButton: FloatingActionButton(
          backgroundColor: MaterialColor(0xFFF8B948, color),
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditTodoPage()),
            );

            refreshTodo();
          },
        ),
      );

  // Build the whole list of todo items
  Widget buildTodo() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: todos.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final todo = todos[index];

          return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodoDetailPage(todoId: todo.id!),
                ));

                refreshTodo();
              },
              child: TodoCardWidget(todo: todo, index: index));
        },
      );
}
