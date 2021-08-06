import 'package:flutter/material.dart';
import 'package:notice_flutter_app/widgets/nav-drawer.dart';
import 'package:notice_flutter_app/routes/routes.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white)),
            drawer: NavDrawer(),
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  Container(
                      child: ListTile(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.notes);
                          },
                          title: Text(
                            'Notes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )),
                      color: Colors.orange.shade100),
                  SizedBox(height: 3),
                  Container(
                      child: ListTile(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.to_do);
                          },
                          title: Text(
                            'To-Do',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                      color: Colors.orange.shade100),
                  SizedBox(height: 3),
                  Container(
                      child: ListTile(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.events);
                          },
                          title: Text(
                            'Events',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                      color: Colors.orange.shade100),
                  SizedBox(height: 3),
                ]))));
  }
}
