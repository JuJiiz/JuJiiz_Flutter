import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/event_model.dart';
import 'package:flutter_app/src/models/user_model.dart';

class EventApproveDialog extends StatelessWidget {
  final EventModel eventModel;
  final UserModel userModel;

  EventApproveDialog(this.userModel, this.eventModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            child: Image.network(
              userModel.picture,
            ),
            padding: EdgeInsets.only(bottom: 8.0),
          ),
          Text('${userModel.uid}'),
          Text(
            '${userModel.first_name} ${userModel.last_name}',
            textScaleFactor: 1.5,
          ),
          Text(
            '(${userModel.display_name})',
            textScaleFactor: 1.2,
          ),
        ],
      ),
      actions: <Widget>[
        Container(
            child: Row(
          children: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            /*new FlatButton(
              child: new Text(
                "Add point",
                textScaleFactor: 1.0,
              ),
              onPressed: null,
            ),*/
            FlatButton(
              child: Text(
                "Approve",
                textScaleFactor: 1.0,
              ),
              onPressed: null,
            ),
          ],
        ))
      ],
    );
  }
}
