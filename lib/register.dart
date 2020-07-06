import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
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
