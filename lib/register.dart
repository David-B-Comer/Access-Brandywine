import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:newflutterapp/main.dart';
import 'package:image_picker/image_picker.dart';

import 'components.dart';
import 'constants.dart';
import 'passport.dart';

class RegistrationPage extends StatefulWidget {
  static String id = 'registration';

  String get title => 'Registration Page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // create a new authentication instance
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bw.jpg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //This does something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  // This does something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, PassportPage.id);
                    }
                  } catch (e) {
                    print(e);
                  }

                  //Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class _RegistrationPageState extends State<RegistrationPage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_image: $_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Registration Page',
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bw4.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(225, 225, 225, .58),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              widget.title,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(225, 225, 225, .2),
                      hintText: 'Enter your first name',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your last name',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: 'Re-enter password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(225, 225, 225, .2),
                      hintText: 'Upload photo',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 36.0),
                  child: Material(
                    color: Color.fromRGBO(255, 255, 255, .4),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        // push the current context to the routeName
                        Navigator.pushNamed(context, '/');
                      },
                      minWidth: 200.0,
                      height: 82.0,
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */

/*
Flexible(
              flex: 3,
              child: TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  hintText: 'Secret Question',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Flexible(
              flex: 3,
              child: TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  hintText: 'Answer to Question',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
 */
