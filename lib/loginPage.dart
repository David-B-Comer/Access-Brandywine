import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newflutterapp/register.dart';
import 'passport.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  String get title => 'Login Page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: 'Login',
              onPressed: () {
                signUpWithMail();
              },
              backgroundColor: Colors.orange,
            ),
            SizedBox(
              height: 35,
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
