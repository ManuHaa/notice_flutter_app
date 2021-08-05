import 'package:flutter/material.dart';

import 'package:notice_flutter_app/routes/routes.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'OrganiZer',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                /*image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))*/),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Welcome'),
            onTap: ()  {Navigator.pushReplacementNamed(context, Routes.home);},
          ),
          ListTile(
            leading: Icon(Icons.notes),
            title: Text('Notes'),
            onTap: ()  {Navigator.pushReplacementNamed(context, Routes.notes);},
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('To-Dos'),
            onTap: ()  {Navigator.pushReplacementNamed(context, Routes.to_do);},
          ),
          ListTile(
            leading: Icon(Icons.checklist_outlined),
            title: Text('Events'),
            onTap: ()  {Navigator.pushReplacementNamed(context, Routes.events);},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: ()  {Navigator.pushReplacementNamed(context, Routes.profile);},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: ()  {Navigator.pushReplacementNamed(context, Routes.login);},
          ),
        ],
      ),
    );
  }
}