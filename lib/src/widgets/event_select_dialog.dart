import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/event_model.dart';
import 'package:flutter_app/src/ui/scanner_ui.dart';

class EventSelectDialog extends StatelessWidget {
  final List<EventModel> events;

  EventSelectDialog(this.events);

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('Select'),
      children: events.map((value) {
        return SimpleDialogOption(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (_) => ScanScreen(eventModel: value)));
          },
          child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              padding: EdgeInsets.all(20.0),
              //margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(value.title),
                    flex: 4,
                  ),
                  Flexible(
                    child: Text(value.point),
                    flex: 1,
                  ),
                ],
              )), //item value
        );
      }).toList(),
    );
  }
}
