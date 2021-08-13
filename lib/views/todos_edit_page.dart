import 'package:flutter/material.dart';
import 'package:notice_flutter_app/db/todo_database.dart';
import 'package:notice_flutter_app/model/todo.dart';
import 'package:notice_flutter_app/widgets/todo_form_widget.dart';

class AddEditTodoPage extends StatefulWidget {
  final Todo? todo;
  const AddEditTodoPage({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  _AddEditTodoPage createState() => _AddEditTodoPage();
}

class _AddEditTodoPage extends State<AddEditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    number = widget.todo?.number ?? 0;
    title = widget.todo?.title ?? '';
    description = widget.todo?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: new Text('ToDos', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white)),
        body: Form(
          key: _formKey,
          child: TodoFormWidget(
            number: number,
            title: title,
            description: description,
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
        persistentFooterButtons: [buildButton()],
      );

  Widget buildButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        addOrUpdateTodo();
      },
      icon: Icon(Icons.save),
      label: Text('Save'),
      backgroundColor: Colors.green,
    );
  }

  void addOrUpdateTodo() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.todo != null;

      if (isUpdating) {
        await updateTodo();
      } else {
        await addTodo();
      }

      Navigator.of(context).pop();
    }
  }

  //add a todo and save in db
  Future addTodo() async {
    final todo = Todo(number: number, title: title, description: description);

    await TodoDatabase.instance.create(todo);
  }

  //update a todo and save in db
  Future updateTodo() async {
    final todo = widget.todo!.copy(title: title, description: description);

    await TodoDatabase.instance.update(todo);
  }
}
