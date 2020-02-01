import 'package:flutter/material.dart';

class aboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: Text("About"),),
      body: new Center(
        child: Text("Communication Academy"),
      ),
    );
  }
}