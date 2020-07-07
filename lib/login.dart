import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:newflutterapp/passport.dart';
import 'register.dart';
// ignore: implementation_imports
import 'package:flutter/src/material/colors.dart';

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
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              image: AssetImage('images/BrandywineRiver.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 220,
              height: 40,
              child: TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: emailTextController,
              ),
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: TextFormField(
                obscureText: true,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an password';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: passwordTextController,
              ),
            ),
            RaisedButton(
                child: Text("LOGIN"),
                onPressed: () {
                  Navigator.pushNamed(context, PassportPage.id);
                }),
            SignInButtonBuilder(
              text: 'Login with Email',
              icon: Icons.email,
              onPressed: () {
                signUpWithMail().whenComplete(
                    () => Navigator.pushNamed(context, PassportPage.id));
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
                _googleSignUp().whenComplete(
                    () => Navigator.pushNamed(context, PassportPage.id));
              },
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 220,
              height: 40,
              child: RaisedButton(
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

      return user;
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
        return user;
      }
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithMail() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Success sign up'),
            );
          });
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }
}
