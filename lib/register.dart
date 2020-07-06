import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newflutterapp/main.dart';

class RegistrationPage extends StatelessWidget {
  static String id = 'registration';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Registration Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/BrandywineRiver.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: RaisedButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
            child: Text('Go back to HomePage!'),
          ),
        ),
      ),
    );
  }
}
