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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/api.png'),

                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF3383CD),
                          Color(0xFF11249F),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100, 120, 30, 10),
                      child: Text(
                        'Codeforces API',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Codeforces Handle',
                          prefixIcon: Icon(Icons.account_box),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
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
                      SizedBox(height: 20,),
                      RaisedButton(
                        color: Colors.teal,
                        splashColor: Colors.blue[300],
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.grey[100],
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
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height-80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
