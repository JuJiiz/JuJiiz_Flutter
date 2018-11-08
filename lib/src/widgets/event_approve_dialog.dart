import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/event_model.dart';
import 'package:flutter_app/src/models/user_model.dart';
import 'package:http/http.dart' as http;

class EventApproveDialog extends StatelessWidget {
  final EventModel eventModel;
  final UserModel userModel;

  EventApproveDialog(this.userModel, this.eventModel);

  @override
  Widget build(BuildContext context) {
    void _postData() {
      Map body = {
        'uid': userModel.uid,
        'key': eventModel.key,
        'point': /*eventModel.point*/ '1',
        'date': '${DateTime.now().millisecondsSinceEpoch}',
      };

      http
          .post(
              Uri.encodeFull(
                  'https://us-central1-young-happy.cloudfunctions.net/insertPost/insertUser'),
              body: body)
          .then((http.Response response) {
        print('body: ${response.body}');
        print('statusCode: ${response.statusCode}');
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        Navigator.of(context).pop();
      });
    }

    String mUID =
        (userModel.uid).replaceRange(0, (userModel.uid).length - 6, '');

    var mainContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Stack(
            //alignment: Alignment.bottomRight,
            children: <Widget>[
              FadeInImage.assetNetwork(
                width: 250.0,
                height: 250.0,
                placeholder: 'assets/user_placeholder.png',
                image: userModel.picture,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                  child: Align(
                child: Text('$mUID',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400)),
                alignment: Alignment.bottomRight,
              )),
            ],
          ),
        ),
        Container(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 20.0, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                      text: 'First name : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${userModel.first_name}'),
                ],
              ),
            ),
            alignment: Alignment.topLeft),
        Container(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 20.0, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Last name : ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${userModel.last_name}'),
                ],
              ),
            ),
            alignment: Alignment.topLeft),
      ],
    );

    return AlertDialog(
      title: Text('Information'),
      content: mainContent,
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
            FlatButton(
              child: Text(
                "Approve",
                textScaleFactor: 1.0,
              ),
              onPressed: _postData,
            ),
          ],
        ))
      ],
    );
  }
}
