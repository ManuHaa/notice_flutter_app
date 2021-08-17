import 'package:flutter/material.dart';
import 'package:notice_flutter_app/colorpalette/colorpalette.dart';
import 'dart:async';
import 'package:notice_flutter_app/db/todo_database.dart';
import 'package:notice_flutter_app/model/todo.dart';
import 'package:notice_flutter_app/views/todos_add_page.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';
import 'package:sqflite/sqflite.dart';

class Todos extends StatelessWidget {
  static const String routeName = '/to_do';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Todo',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white)),
            drawer: NavDrawer(),
            body: TodoList()));
  }
}

class TodoList extends StatefulWidget {
  static const String routeName = '/to_do';
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  void navigateToDetail(Todo todo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      Text("No Notes to Show");
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      updateListView();
    }
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Do You Really Want To Exit?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: getTodoListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MaterialColor(0xFFF8B948, color),
          child: Icon(Icons.add),
          onPressed: () {
            navigateToDetail(Todo("", "", 2), "Add Todo");
          },
        ),
      ),
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.orange.shade100,
          elevation: 4.0,
          child: ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_circle_outline_outlined),
            ),
            title: Text(
              this.todoList[position].title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            subtitle: Text(
              this.todoList[position].date,
              style: TextStyle(color: Colors.black),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              onTap: () {
                navigateToDetail(this.todoList[position], "Edit Todo");
              },
            ),
          ),
        );
      },
    );
  }
}
