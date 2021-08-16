import 'package:flutter/material.dart';
import 'package:notice_flutter_app/views/todos_add_page.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';

import 'package:notice_flutter_app/model/todo.dart';

import 'todos_add_page.dart';

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

  /*@override
  void initState() {
    super.initState();
    refreshTodo();
  }*/

  //close the DB
  /*@override
  void dispose() {
    TodoDatabase.instance.close();
    super.dispose();
  }*/

  //refresh the db
  /*Future refreshTodo() async {
    setState(() => isLoading = true);
    this.todos = await TodoDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddPage())),
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 80.0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My Tasks',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '1 of 10',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }
            return buildTask(index);
          },
        ));
  }

  Widget buildTask(int index) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            ListTile(
              title: Text('Task Title'),
              subtitle: Text('...'),
              trailing: Checkbox(
                onChanged: (value) {
                  print(value);
                },
                activeColor: Theme.of(context).primaryColor,
                value: true,
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            )
          ],
        ));
  }

  // Build the whole list of todo items
  /*Widget buildTodo() => StaggeredGridView.countBuilder(
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
      );*/
}
