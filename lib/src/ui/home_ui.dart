import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/event_model.dart';
import 'package:flutter_app/src/widgets/event_select_dialog.dart';
import 'package:flutter_app/src/widgets/modal_progress_hud.dart';
import 'package:http/http.dart' show get;

class Home extends StatefulWidget {
  static String tag = 'Home';

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  bool _isInAsyncCall = false;

  initState() {
    super.initState();
  }

  void _fetchEvent() async {
    setState(() {
      _isInAsyncCall = true;
    });
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

    setState(() {
      _isInAsyncCall = false;
    });
  }

  Widget build(BuildContext context) {
    final _homeView = Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: PhysicalModel(
            elevation: 2.0,
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(0.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    'Event approval',
                    textScaleFactor: 1.5,
                  ),
                ),
                textColor: Colors.white,
                onPressed: _fetchEvent,
                elevation: 0.0,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      color: Colors.grey,
      child: _homeView,
    );
  }
}
