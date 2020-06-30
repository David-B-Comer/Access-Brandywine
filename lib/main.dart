import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Access Brandywine',
      debugShowCheckedModeBanner: false,
      home: PictureScreen(),
    );
  }
}

class PictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/BrandywineRiver.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Access Brandywine'),
            backgroundColor: Colors.grey[900],
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 60, left: 70, right: 85),
            child: Column(
              children: [
                SizedBox(height: 4.0),
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  height: 60.0,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Enter Email',
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(top: 230, left: 90, right: 70),
            child: Column(
              children: [
                SizedBox(height: 2.0),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  color: Colors.white,
                  height: 60.0,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
