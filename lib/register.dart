import 'package:flutter/cupertino.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{

final AuthService _auth = AuthService();

String email = '';
String password = '';

@override
Widget Build(BuildContext context) {
  return Scaffold
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AuthService {
}