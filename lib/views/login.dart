import 'package:flutter/material.dart';
import 'package:notice_flutter_app/views/home.dart';
//import 'package:notice_flutter_app/views/password_reset.dart';
import 'package:notice_flutter_app/colorpalette/colorpalette.dart';

class Login extends StatelessWidget {
  static const String routeName = '/login';

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 220.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/logo_small.png')),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter valid username id'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            /*TextButton(
              onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => PasswordReset()));
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),*/
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: MaterialColor(0xFFF8B948, color), borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  if(usernameController.text == "flomann" && passwordController.text == "12345" || usernameController.text == "haugman" && passwordController.text == "12345") {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Home()));
                  } else {
                    _showDialog(context);
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Login failed"),
        content: new Text("Please try again"),
        actions: <Widget>[
          new TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
