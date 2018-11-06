import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/src/models/staff_model.dart';
import 'package:flutter_app/src/ui/login_ui.dart';

class RegisterApproveDialog extends StatelessWidget {
  final String email, password, confirmPassword;
  final BaseAuth auth;

  RegisterApproveDialog(
      this.auth, this.email, this.password, this.confirmPassword);

  /*void _firebaseRegister(BuildContext context) async {
    try {
      String user = await auth.createUserWithEmailAndPassword(
          email, password);
      print('Firebase Auth User: $user');

      if (user != null) {
        DatabaseReference database = FirebaseDatabase.instance
            .reference()
            .child('users-admin')
            .child(user);

        database.once().then((DataSnapshot snapshot) {
          StaffModel staffModel = StaffModel(
              uid: user,
              email: email,
              allowed: false,
              register_date: DateTime
                  .now()
                  .millisecondsSinceEpoch);

          database.set(staffModel.toJson()).whenComplete(() =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Login.tag, (Route<dynamic> route) => false));
        });
      }
    } catch (e) {
      print('Firebase Auth Error: $e');
    }
  }*/

  Widget build(BuildContext context) {
    String mPass = password;
    String mConPass = confirmPassword;

    for (var i = 0; i < password.length - 3; i++)
      mPass = mPass.replaceRange(i, mPass.length - 3, '*');

    for (var i = 0; i < confirmPassword.length - 3; i++)
      mConPass = mConPass.replaceRange(i, mConPass.length - 3, '*');

    return AlertDialog(
      title: new Text('Confirmation'),
      content: new Text('Email: $email\n'
          'Password: $mPass\n'
          'Confirm password: $mConPass\n'
          '\n* Your request must be approve by admin before login'),
      actions: <Widget>[
        Container(
            child: Row(
          children: <Widget>[
            ProgressButton(
              auth: auth,
              email: email,
              password: password,
            )
            /*new FlatButton(
                  child: Text(
                    "OK",
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () {
                    _firebaseRegister(context);
                  },
                ),*/
          ],
        ))
      ],
    );
  }
}

class ProgressButton extends StatefulWidget {
  ProgressButton({this.auth, this.email, this.password});

  final BaseAuth auth;
  final String email;
  final String password;

  @override
  _ProgressButtonState createState() => new _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  Color _color = Colors.lightGreen;
  double _width = 100.0;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 2.0,
      color: _color,
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        key: _globalKey,
        height: 48.0,
        width: _width,
        child: new RaisedButton(
          padding: EdgeInsets.all(0.0),
          child: setUpButtonChild(),
          onPressed: () {
            setState(() {
              if (_state == 0) {
                animateButton();
              }
            });
          },
          elevation: 0.0,
          color: Colors.transparent,
        ),
      ),
    );
  }

  ///
  ///
  ///
  setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Submit",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36.0,
        width: 36.0,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() async {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });

    setState(() {
      _state = 1;
      _color = Colors.lightGreen;
      _controller.forward();
    });

    try {
      String user = await widget.auth
          .createUserWithEmailAndPassword(widget.email, widget.password);
      print('Firebase Auth User: $user');

      if (user != null) {
        DatabaseReference database = FirebaseDatabase.instance
            .reference()
            .child('users-admin')
            .child(user);

        database.once().then((DataSnapshot snapshot) {
          StaffModel staffModel = StaffModel(
              uid: user,
              email: widget.email,
              allowed: false,
              register_date: DateTime.now().millisecondsSinceEpoch);

          setState(() {
            _state = 2;
          });

          database.set(staffModel.toJson()).whenComplete(() =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Login.tag, (Route<dynamic> route) => false));
        });
      }
    } catch (e) {
      setState(() {
        _width = 100.0;
        _color = Colors.redAccent;
        _state = 0;
        _controller.forward();
      });
      print('Firebase Auth Error: $e');
    }
  }
}
