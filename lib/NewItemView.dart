import 'package:flutter/material.dart';

class NewItemView extends StatefulWidget{
  @override
  _NewItemViewState createState() => _NewItemViewState();
}

class _NewItemViewState extends State<NewItemView>{
  final keyText = TextEditingController();
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Course"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: keyText,
              onEditingComplete:() => save(),
            ),
            FlatButton(
              onPressed: () => save(),
              child: Text("Add"),
              color: Colors.green,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
    void save(){
      if(keyText.text.isNotEmpty) {
        Navigator.of(context).pop(keyText.text);
      }
    }
  }