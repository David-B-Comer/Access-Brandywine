import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:newflutterapp/constants.dart';
import 'package:newflutterapp/passport.dart';
import 'passport.dart';
import 'register.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:newflutterapp/generated_plugin_registrant.dart';

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
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  FirebaseUser loggedInUser;
  bool showSpinner = false;

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
              height: 36,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 220,
              height: 36,
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
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
            SignInButtonBuilder(
              icon: Icons.mail,
              text: 'Press to login',
              onPressed: () {
                signUpWithMail();
              },
              backgroundColor: Colors.orange,
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Login with Facebook",
              onPressed: () {
                signUpWithFacebook();
              },
            ),
            SignInButton(
              Buttons.Google,
              text: "Login with Google",
              onPressed: () {
                _googleSignUp();
              },
            ),

            SizedBox(
              height: 5,
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

  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      if (user != null) {
        Navigator.pushNamed(context, PassportPage.id);
      }
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithFacebook() async {
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);

        Navigator.pushNamed(context, PassportPage.id);
      }
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithMail() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, PassportPage.id);
      }
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'An error occurred. Please re-enter email and password or register for an account'),
            );
          });
    }
  }
}
