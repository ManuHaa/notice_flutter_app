import 'package:flutter/material.dart';
import 'package:notice_flutter_app/colorpalette/colorpalette.dart';
import 'package:notice_flutter_app/model/todo.dart';
import 'package:notice_flutter_app/db/todo_database.dart';
import 'package:intl/intl.dart';

class TodoDetail extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;

  TodoDetail(this.todo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return TodoDetailState(this.todo, this.appBarTitle);
  }
}

class TodoDetailState extends State<TodoDetail> {
  static var _prioities = ["High", "Low"];
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Todo todo;

  TodoDetailState(this.todo, this.appBarTitle);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    titleController.text = todo.title;
    descriptionController.text = todo.description;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.orange.shade50,
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: MaterialColor(0xFFF8B948, color),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                  //dropdown menu
                  child: new ListTile(
                    leading: const Icon(Icons.low_priority),
                    title: DropdownButton(
                        items: _prioities.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          );
                        }).toList(),
                        value: getPriorityAsString(todo.priority),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                  ),
                ),
                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      icon: Icon(Icons.title),
                    ),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                  child: TextFormField(
                    maxLines: 15,
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'Details',
                      icon: Icon(Icons.details),
                    ),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                          ),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                          ),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();
    todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todo.id != null) {
      result = await helper.updateTodo(todo);
    } else {
      result = await helper.insertTodo(todo);
    }

    if (result != 0) {
      _showAlertDialog("Status", "Todo Saved Successfully");
    } else {
      _showAlertDialog("Status", "Problem In Saving Note");
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (todo.id == null) {
      _showAlertDialog("Status", "First Add a Todo");
      return;
    }
    int result = await helper.deleteTodo(todo.id);

    if (result != 0) {
      _showAlertDialog("Status", "Todo delete Successfully");
    } else {
      _showAlertDialog("Status", "Sorry, Error");
    }
  }

  //Convert Priority to Int to Save it into Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case "High":
        todo.priority = 1;
        break;
      case "Low":
        todo.priority = 2;
        break;
      default:
    }
  }

  //Converting the Priority into String for showing to User
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _prioities[0];
        break;
      case 2:
        priority = _prioities[1];
        break;
      default:
    }
    return priority;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
