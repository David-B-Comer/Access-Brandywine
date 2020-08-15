import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'passport.dart';

// ignore: must_be_immutable
class RegistrationPage extends StatefulWidget {
  static String id = 'registration';

  String get title => 'Registration Page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // create a new authentication instance
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  String email;
  String password;
  bool showSpinner = false;
  String firstName;
  String lastName;
  String phoneNumber;
  String photo;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  AlertDialog alert = AlertDialog(
    title: Center(
      child: Text(
        'Alert',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(
            'Please complete all fields',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );

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
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bw.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 220,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 14),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  firstName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your first name'),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 14),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  lastName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your last name'),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: TextField(
                keyboardType: TextInputType.number,
                obscureText: true,
                style: TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phoneNumber = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your phone number'),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Colors.green,
                    )),
                color: Colors.white,
                child: Text(
                  'Register for Account',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                onPressed: () async {
                  _firestore.collection('guests').add({
                    'email': email,
                    'firstName': firstName,
                    'lastName': lastName,
                    'phoneNumber': phoneNumber,
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if ((newUser != null) &&
                        (firstName != null) &&
                        (lastName != null) &&
                        (phoneNumber != null)) {
                      Navigator.pushNamed(context, PassportPage.id);
                    } else {
                      Navigator.pushNamed(context, RegistrationPage.id);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          });
                    }
                  } catch (e) {
                    print(e.message);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'Email may already be in use, or invalid info has been entered. Please re-enter information'),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  //Navigator.pushNamed(context, LoginScreen.id);}
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

*/
