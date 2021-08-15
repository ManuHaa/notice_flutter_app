import 'package:flutter/material.dart';

import 'package:notice_flutter_app/widgets/nav-drawer.dart';
import 'package:notice_flutter_app/routes/routes.dart';
import 'package:notice_flutter_app/views/notes.dart';
import 'package:notice_flutter_app/views/events.dart';
import 'package:notice_flutter_app/views/login.dart';
import 'package:notice_flutter_app/views/profile.dart';
import 'package:notice_flutter_app/views/todos.dart';
import 'package:notice_flutter_app/views/home.dart';
import 'package:notice_flutter_app/colorpalette/colorpalette.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrganiZer',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF8B948, color),
      ),
      home: Login(),
      routes: {
        Routes.home: (context) => Home(),
        Routes.notes: (context) => Notes(),
        Routes.events: (context) => Events(),
        Routes.to_do: (context) => ToDo(),
        Routes.profile: (context) => Profile(),
        Routes.login: (context) => Login(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
    );
  }
}
