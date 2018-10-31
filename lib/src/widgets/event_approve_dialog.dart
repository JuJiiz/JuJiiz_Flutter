import 'package:flutter/material.dart';

class EventApproveDialog extends StatelessWidget {
  final String uid;

  EventApproveDialog(this.uid);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Information'),
      content: new Text(uid),
      actions: <Widget>[
        Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            //padding: EdgeInsets.all(20.0),
            //margin: EdgeInsets.all(20.0),
            child: Row(
          children: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                textScaleFactor: 2.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Add point",
                textScaleFactor: 2.0,
              ),
              onPressed: null,
            ),
            new FlatButton(
              child: new Text(
                "Approve",
                textScaleFactor: 2.0,
              ),
              onPressed: null,
            ),
          ],
        ))
      ],
    );
  }
}
