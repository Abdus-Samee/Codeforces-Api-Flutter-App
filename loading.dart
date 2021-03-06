import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterapi/api.dart';
import 'package:flutterapi/home.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {

  String _handle;

  Loading(String handle){
    _handle = handle;
  }

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async {
    Api o = new Api(widget._handle);
    await o.getInfo();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (BuildContext context) => HomePage(o.m, o.verdict, o.rating)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.grey[300],
          size: 50,
        ),
      ),
    );
  }
}
