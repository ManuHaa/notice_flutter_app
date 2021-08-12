import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';
import 'package:notice_flutter_app/colorpalette/colorpalette.dart';

//StatelessWidget -> sind nicht veränderbar
//ist der Balken oben
class ToDo extends StatelessWidget {
  static const String routeName = '/to-do';
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Scaffold(
        appBar: new AppBar(
            title: new Text('To-Dos', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white)),
        drawer: new NavDrawer(),
        body: new ToDoList(),
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
  List<String> _todoItems = <String>[];

  //add a time, if the user write min. one char
  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(
          task)); //set state verursacht, das die Daten direkt aktualisiert werden
    }
  }

  //delete a to do
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  //wenn ich auf die vorhandenen Todos drücke
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text(
                  'Mark "${_todoItems[index]}" as done?'), //if the user press on the todo
              actions: <Widget>[
                new TextButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()),
                new TextButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
        return new ListTile();
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new Container(
        child: ListTile(
          title: new Text(
            todoText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          onTap: () => _promptRemoveTodoItem(index),
        ),
        color: Colors.orange.shade100);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _buildTodoList(),
        //Butten zum hinzufügen
        floatingActionButton: new FloatingActionButton(
          backgroundColor: MaterialColor(0xFFF8B948, color),
          onPressed: () => _pushAddTodoScreen(),
          tooltip: 'Add Item',
          child: new Icon(Icons.add),
        ));
  }

  //neuer Screen, wenn wir auf das add Symbol drücken
  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        // MaterialPageRoute will automatically animate the screen entry, as well
        // as adding a back button to close it
        new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
