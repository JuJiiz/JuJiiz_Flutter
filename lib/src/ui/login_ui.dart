import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/home_ui.dart';
import 'package:flutter_app/src/ui/register_ui.dart';

class Login extends StatefulWidget {
  static String tag = 'Login';

  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  String dummyEmail = 'ju.jiiz.1579@gmail.com';
  String dummyPassword = 'JuJiizTest';

  final GlobalKey<FormState> _keyLogin = new GlobalKey<FormState>();
  bool _validateLogin = false;
  String _email, _password;

  initState() {
    super.initState();
  }

  String validateEmail(String value) {
    _email = value;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    _password = value;
    if (value.length < 6)
      return 'Password must be more than 6 charater';
    else
      return null;
  }

  void _sendToServer() {
    if (_keyLogin.currentState.validate()) {
      _keyLogin.currentState.save();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Home()));
    } else {
      setState(() {
        _validateLogin = true;
      });
    }
  }

  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: dummyEmail,
      validator: validateEmail,
      onSaved: (String val) {
        _email = val;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: dummyPassword,
      obscureText: true,
      validator: validatePassword,
      onSaved: (String val) {
        _password = val;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = OutlineButton(
        child: Text('Log In', style: TextStyle(color: Colors.lightBlueAccent)),
        borderSide: BorderSide(color: Colors.lightBlueAccent),
        //color: Colors.lightBlueAccent,
        onPressed: _sendToServer,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ));

    final registerLabel = FlatButton(
      child: Text(
        'Register',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(Register.tag);
      },
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _keyLogin,
            autovalidate: _validateLogin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 48.0),
                Text(
                  'Login',
                  textScaleFactor: 1.5,
                ),
                SizedBox(height: 24.0),
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                registerLabel,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
