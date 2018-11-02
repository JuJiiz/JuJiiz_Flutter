import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/event_model.dart';

class EventApproveDialog extends StatelessWidget {
  final String uid;
  final EventModel event;

  EventApproveDialog(this.uid, this.event);

  @override
  Widget build(BuildContext context) {
    print('${event.key} : ${event.title} : ${event.point}');
    return AlertDialog(
      title: new Text('Information'),
      content: new Text('$uid'),
      actions: <Widget>[
        Container(
            child: Row(
          children: <Widget>[
            new FlatButton(
              child: new Text(
                "Cancel",
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Add point",
                textScaleFactor: 1.0,
              ),
              onPressed: null,
            ),
            new FlatButton(
              child: new Text(
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
