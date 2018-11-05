import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/src/models/user_model.dart';
import 'package:flutter_app/src/ui/login_ui.dart';

class RegisterApproveDialog extends StatelessWidget {
  final String email, password, confirmPassword;
  final BaseAuth auth;

  RegisterApproveDialog(
      this.auth, this.email, this.password, this.confirmPassword);

  void _firebaseRegister(BuildContext context) async {
    try {
      String user = await auth.createUserWithEmailAndPassword(email, password);
      print('Firebase Auth User: $user');

      if (user != null) {
        DatabaseReference database = FirebaseDatabase.instance
            .reference()
            .child('users-admin')
            .child(user);

        database.once().then((DataSnapshot snapshot) {
          if (snapshot.value == null) {
            UserModel userModel = UserModel(
                uid: user,
                email: email,
                allowed: false,
                register_date: DateTime.now().millisecondsSinceEpoch);

            database.set(userModel.toJson()).whenComplete(() =>
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Login.tag, (Route<dynamic> route) => false));
          }
        });
      }
    } catch (e) {
      print('Firebase Auth Error: $e');
    }
  }

  @override
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
            new FlatButton(
              child: new Text(
                "OK",
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                _firebaseRegister(context);
              },
            ),
          ],
        ))
      ],
    );
  }
}
