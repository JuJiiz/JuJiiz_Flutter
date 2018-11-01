import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/login_ui.dart';

class RegisterApproveDialog extends StatelessWidget {
  final String email;

  RegisterApproveDialog(this.email);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Waiting for Admin Approval'),
      content: new Text('email: $email'),
      actions: <Widget>[
        Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            //padding: EdgeInsets.all(20.0),
            //margin: EdgeInsets.all(20.0),
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
