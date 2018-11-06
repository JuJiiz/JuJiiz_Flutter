import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/event_model.dart';
import 'package:flutter_app/src/widgets/event_select_dialog.dart';
import 'package:http/http.dart' show get;

class Home extends StatefulWidget {
  static String tag = 'Home';

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  initState() {
    super.initState();
  }

  void _fetchEvent() async {
    var response = await get(
        'https://us-central1-young-happy.cloudfunctions.net/eventGet/getEvent');
    var responseJson = json.decode(response.body);
    print('data : ${responseJson['data']}');
    var events = (responseJson['data'] as List)
        .map((p) => EventModel.fromJson(p))
        .toList();
    if (events.length != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return EventSelectDialog(events);
          });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: RaisedButton(
            child: Text('Event approval'),
            textColor: Colors.black87,
            color: Colors.lightGreen,
            onPressed: _fetchEvent,
          ),
        ),
      ),
    );
  }
}
