import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/image_model.dart';
import 'package:flutter_app/src/widgets/image_list.dart';
import 'package:http/http.dart' show get;

class App extends StatefulWidget {
  static String tag = 'App';
  
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    var res = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(res.body));
    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('JuJiiz'),
        ),
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImage,
        ),
      ),
    );
  }
}
