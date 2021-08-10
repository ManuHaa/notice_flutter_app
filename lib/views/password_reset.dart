import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';

class PasswordReset extends StatelessWidget {
  static const String routeName = '/password-reset';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Password Reset',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white)),
            drawer: NavDrawer()));
  }
}
