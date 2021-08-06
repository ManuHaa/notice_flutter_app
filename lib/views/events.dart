import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';

class Events extends StatelessWidget {
  static const String routeName = '/events';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Events',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white)),
            drawer: NavDrawer()));
  }
}
