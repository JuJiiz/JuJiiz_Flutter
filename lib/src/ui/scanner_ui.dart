import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/models/event_model.dart';
import 'package:flutter_app/src/models/user_model.dart';
import 'package:flutter_app/src/widgets/event_approve_dialog.dart';
import 'package:http/http.dart' show get;

class ScanScreen extends StatefulWidget {
  static String tag = 'ScanScreen';
  final EventModel eventModel;

  ScanScreen({/*@required*/ this.eventModel});

  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  EventModel eventModel;

  initState() {
    super.initState();
  }

  Future _getUserInformation(String uid) async {
    var response = await get(
        'https://us-central1-young-happy.cloudfunctions.net/userGet/getUser?uid=$uid');
    var responseJson = json.decode(response.body);

    var user = UserModel.fromJson(responseJson['data']);
    if (user != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return EventApproveDialog(user, this.eventModel);
          });
    }
  }

  Widget build(BuildContext context) {
    setState(() {
      eventModel = widget.eventModel;
    });

    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: _scan,
                    child: const Text('START CAMERA SCAN')),
              ),
            ],
          ),
        ));
  }

  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      var user = barcode.split('uid=');
      if (user.length == 2 && this.eventModel != null) {
        _getUserInformation(user[1]);
      }

      //setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        /*setState(() {
          this.uid = 'The user did not grant the camera permission!';
        });*/
      } else {
        //setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      /*setState(() =>
      this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');*/
    } catch (e) {
      //setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
