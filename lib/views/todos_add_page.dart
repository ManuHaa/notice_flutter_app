import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  final formkey = GlobalKey<FormState>();
  String title = '';
  late String priority;
  DateTime date = DateTime.now();
  TextEditingController dateController = TextEditingController();

  final DateFormat dateFormatter = DateFormat('dd.MMM.yyyy');
  final List<String> priorities = ['LOW', 'MEDIUM', 'HIGH'];

  @override
  void initState() {
    super.initState();
    dateController.text = dateFormatter.format(date);
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  handleDatePicker() async {
    final DateTime? _date = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_date != null && date != date) {
      setState(() {
        date = _date;
      });
      dateController.text = dateFormatter.format(date);
    }
  }

  submit() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      print('$title, $date, $priority');

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Add Task',
            style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                            labelText: 'title',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter a task title'
                            : null,
                        onSaved: (input) => title == input,
                        initialValue: title,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        readOnly: true,
                        controller: dateController,
                        style: TextStyle(fontSize: 18.0),
                        onTap: handleDatePicker,
                        decoration: InputDecoration(
                            labelText: 'date',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 22.0,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        items: priorities.map((String priority) {
                          return DropdownMenuItem(
                              value: priority,
                              child: Text(priority,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0)));
                        }).toList(),
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                            labelText: 'priorities',
                            labelStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        // ignore: unnecessary_null_comparison
                        validator: (input) => priority == null
                            ? 'Please select a priority'
                            : null,
                        onChanged: (value) {
                          setState(() {
                            // ignore: unnecessary_statements
                            priority == value;
                          });
                        },
                        value: priority,
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: TextButton(
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: submit,
                      )),
                ],
              ))
        ],
      ),
    ));
  }
}
