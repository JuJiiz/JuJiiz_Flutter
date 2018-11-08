import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/src/mixins/validation_mixins.dart';
import 'package:flutter_app/src/models/staff_model.dart';
import 'package:flutter_app/src/ui/home_ui.dart';
import 'package:flutter_app/src/ui/register_ui.dart';
import 'package:flutter_app/src/widgets/modal_progress_hud.dart';

class Login extends StatefulWidget {
  static String tag = 'Login';
  final BaseAuth auth;

  Login({this.auth});

  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> with ValidationMixin {
  String dummyEmail = 'ju.jiiz.1579@gmail.com';
  String dummyPassword = 'JuJiizTest';
  bool _isInAsyncCall = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _keyLogin = new GlobalKey<FormState>();
  bool _validateLogin = false;
  String _email, _password;
  String userId;

  void initState() {
    super.initState();

    setState(() {
      _isInAsyncCall = true;
    });

    widget.auth.currentUser().then((user) {
      if (user != null) {
        _checkAllowed(user);
      } else {
        setState(() {
          _isInAsyncCall = false;
        });
      }
    });
  }

  _showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _sendToServer() async {
    if (_keyLogin.currentState.validate()) {
      _keyLogin.currentState.save();

      setState(() {
        _isInAsyncCall = true;
      });

      try {
        String user =
            await widget.auth.signInWithEmailAndPassword(_email, _password);
        print('Firebase Auth User: $user');
        if (user != null) {
          _checkAllowed(user);
        }
      } catch (e) {
        setState(() {
          _isInAsyncCall = false;
        });
        print('Firebase Auth Error: $e');
        _showInSnackBar('Login fail');
      }
    } else {
      setState(() {
        _isInAsyncCall = false;
        _validateLogin = true;
      });
    }
  }

  _checkAllowed(String user) {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child('user-staff').child(user);

    database.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var staffModel = new StaffModel.from(snapshot.value);
        if (staffModel.allowed) {
          print('allowed');
          _showInSnackBar('Login success');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Home()));
        } else {
          widget.auth.signOut();
          print('not allowed');
          _showInSnackBar('User not allowed');
        }

        setState(() {
          _isInAsyncCall = false;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    final _loginForm = Scaffold(
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
                TextFormField(
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 24.0),
                OutlineButton(
                    child: Text('Log in',
                        style: TextStyle(color: Colors.lightBlueAccent)),
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                    onPressed: _sendToServer,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    )),
                FlatButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Register.tag);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      color: Colors.grey,
      child: _loginForm,
    );
  }
}
