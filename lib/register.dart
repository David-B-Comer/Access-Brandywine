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
                  _firestore.collection('visitors').add({
                    'email': email,
                    'firstName': firstName,
                    'lastName': lastName,
                    'phoneNumber': phoneNumber,
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, PassportPage.id);
                    } else {
                      Navigator.pushNamed(context, RegistrationPage.id);
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
