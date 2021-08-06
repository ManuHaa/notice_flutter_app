import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';

class Login extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            drawer: NavDrawer()));
  }
}
