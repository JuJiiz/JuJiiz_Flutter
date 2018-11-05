import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/src/mixins/validation_mixins.dart';
import 'package:flutter_app/src/models/user_model.dart';
import 'package:flutter_app/src/ui/home_ui.dart';
import 'package:flutter_app/src/ui/register_ui.dart';

class Login extends StatefulWidget {
  static String tag = 'Login';
  final BaseAuth auth;

  Login({this.auth});

  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> with ValidationMixin {
  String dummyEmail = 'ju.jiiz.1579@gmail.com';
  String dummyPassword = 'JuJiizTest';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _keyLogin = new GlobalKey<FormState>();
  bool _validateLogin = false;
  String _email, _password;

  initState() {
    super.initState();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _sendToServer() async {
    if (_keyLogin.currentState.validate()) {
      _keyLogin.currentState.save();

      try {
        String user =
            await widget.auth.signInWithEmailAndPassword(_email, _password);
        print('Firebase Auth User: $user');

        if (user != null) {
          DatabaseReference database = FirebaseDatabase.instance
              .reference()
              .child('users-admin')
              .child(user);

          database.once().then((DataSnapshot snapshot) {
            if (snapshot.value != null) {
              var userModel = new UserModel.from(snapshot.value);
              if (userModel.allowed) {
                print('allowed');
                showInSnackBar('Login success');

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
              } else {
                widget.auth.signOut();
                print('not allowed');
                showInSnackBar('User not allowed');
              }
            }
          });
        }
      } catch (e) {
        print('Firebase Auth Error: $e');
        showInSnackBar('Login fail');
      }
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
      key: _scaffoldKey,
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
