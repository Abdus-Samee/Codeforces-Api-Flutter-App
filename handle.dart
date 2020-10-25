import 'package:flutter/material.dart';
import 'package:flutterapi/loading.dart';

class Handle extends StatefulWidget {
  @override
  _HandleState createState() => _HandleState();
}

class _HandleState extends State<Handle> {

  String _handle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Codeforces Handle',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Codeforces Handle',
                ),
                validator: (String val){
                  if(val.isEmpty) return 'Handle name is required';
                  if(val.length < 3 || val.length > 24) return 'Field should contain between 3 and 24 characters, inclusive';
                  return null;
                },
                onSaved: (String val){
                  _handle = val;
                },
              ),
              SizedBox(height: 100,),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onPressed: (){
                  if(!_formKey.currentState.validate()) return;
                  _formKey.currentState.save();

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => Loading(_handle),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
