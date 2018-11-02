import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/login_ui.dart';

class RegisterApproveDialog extends StatelessWidget {
  final String email, password, confirmPassword;

  RegisterApproveDialog(this.email, this.password, this.confirmPassword);

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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Login.tag, (Route<dynamic> route) => false);
              },
            ),
          ],
        ))
      ],
    );
  }
}
