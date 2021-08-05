import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';

class ToDo extends StatelessWidget {
  static const String routeName = '/to-do';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('To-Do'),
              centerTitle: true,
            ),
            drawer: NavDrawer()
        ));
  }
}