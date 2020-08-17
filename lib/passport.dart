import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

/*
var snapshots = _firestore
        .collection('profile')
        .document(currentUserID)
        .collection('posts')
        .getDocuments();

await snapshots.forEach((document) async {
  document.reference.updateData(<String, dynamic>{
    name: this.name
  });
})
 */
class PassportPage extends StatefulWidget {
  static String id = 'PassportPage';

  @override
  _PassportPageState createState() => _PassportPageState();
}

class _PassportPageState extends State<PassportPage> {
  final _auth = FirebaseAuth.instance;
  // if currentUser != null, we return a loggedInUser as current user
  FirebaseUser loggedInUser;
  String emailDB;
  String userName;

  //capture user info when state is initialized
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      //will be null if no one is signed in. But if
      //someone has registered or if someone is logged in,
      // it'll tap into the current user email and password
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text('Access Brandywine'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      userName = value;
                    },
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                    radius: 120.0,
                    backgroundImage: AssetImage('images/Desa.jpg'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      emailDB = value;
                    },
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Text(
                    'Expires: 07/01/2020 ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Text(
                    'Last visit: 07/02/2020 ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Text(
                    'Approved by: John Doe',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.white38,
                          onPressed: () => launch("tel://9167051794"),
                          child: Text('Call me')),
                      SizedBox(
                        width: 4,
                      ),
                      RaisedButton(
                          color: Colors.white38,
                          onPressed: () => launch("mailto:apehow111@gmail.com"),
                          child: Text('Email me')),
                      SizedBox(
                        width: 4,
                      ),
                      RaisedButton(
                          color: Colors.white38,
                          onPressed: () => launch("sms://9167051794"),
                          child: Text('Text me')),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: RaisedButton(
                        color: Colors.white38,
                        onPressed: () {
                          _auth.signOut();
                          // push the current context to the routeName
                          Navigator.pop(context);
                          print('logged out');
                        },
                        child: Text(
                          'Logout',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
