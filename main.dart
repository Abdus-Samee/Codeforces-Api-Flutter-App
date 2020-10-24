import 'package:flutter/material.dart';
import 'package:flutterapi/home.dart';
import 'package:flutterapi/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => HomePage({}, {}, {}),
      },
    );
  }
}
