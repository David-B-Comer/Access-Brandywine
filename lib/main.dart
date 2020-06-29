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
        ),
      ],
    );
  }
}
