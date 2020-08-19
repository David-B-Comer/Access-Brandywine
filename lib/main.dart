import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:newflutterapp/loginPage.dart';
import 'package:newflutterapp/passport.dart';
import 'passport.dart';
import 'register.dart';
import 'loginPage.dart';
import 'package:flutter/src/material/colors.dart';


final databaseReference = Firestore.instance;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Access Brandywine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Access Brandywine'),
      initialRoute: '/',
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        MyHomePage.id: (context) => MyHomePage(),
        LoginPage.id: (context) => LoginPage(),
        PassportPage.id: (context) => PassportPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String id = 'MyHomePage';

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//  bool showSpinner = false;

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
              width: 300,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Colors.green,
                    )),
                color: Colors.white,
                child: Text(
                  'Login to Account',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
                onPressed: () => Navigator.of(context).pushNamed(LoginPage.id),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
//
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Colors.green,
                    )),
                color: Colors.white,
                child: Text(
                  'Register for Account',
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(RegistrationPage.id),
              ),
            ),
            //Navigate to second screen
          ],
        ),
      ),
    );
  }
}
