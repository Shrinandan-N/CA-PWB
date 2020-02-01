
import 'dart:ui';

import 'package:communicationacademy/auth.dart';
import 'package:communicationacademy/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'NewItemView.dart';
import 'home.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:communicationacademy/contact.dart';
import 'package:communicationacademy/about.dart';
import 'auth.dart';
import

//tool tip
class StudentHomePage extends StatefulWidget{

  StudentHomePage({Key key, @required this.user, @required this.displayName}) : super(key: key);

  final FirebaseUser user;
  final String displayName;

  _StudentPage createState() => _StudentPage(usr: user, dispName: displayName);

}

class _StudentPage extends State<StudentHomePage> {

  _StudentPage({@required this.usr, @required this.dispName});
  FirebaseUser usr;
  final String dispName;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final String publicSpeakingKey = "pskey";
  final String mathOlympiadKey = "moKey";
  final String debateKey = "dKey";
  final String writingKey = "wKey";
  final classText = TextEditingController();
  Widget goToNewItemView(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context){
              return NewItemView();
            }
        )).then((title){
      int numClasses = 1;

      if(title == publicSpeakingKey) {

        Firestore.instance.collection("users").document(widget.user.uid).updateData(
            {
              "class": FieldValue.arrayUnion(["Public Speaking"])
            });

      }else if(title == mathOlympiadKey) {
        Firestore.instance.collection("users").document(widget.user.uid).updateData(
            {
              "class": FieldValue.arrayUnion(["Math Olympiad Class"])
            });

      }else if(title == debateKey) {
        Firestore.instance.collection("users").document(widget.user.uid).updateData(
            {
              "class": FieldValue.arrayUnion(["Debate Class"])
            });

      }else if(title == writingKey) {
        Firestore.instance.collection("users").document(widget.user.uid).updateData(
            {
              "class": FieldValue.arrayUnion(["Writing Class"])
            });

      }

    });
  }


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home'),
      ),
      drawer: new Drawer(

        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(

                accountName: Text(dispName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                accountEmail: Text("${widget.user.email}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                      image: AssetImage('assets/finalProf.png')
                  ),
                ),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: AssetImage('assets/commLogo.png'),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            new Divider(),
            new ListTile(
              title: new Text("About"),
              trailing: new Icon(Icons.info, color: Colors.green,),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new aboutPage())),

            ),
            new Divider(),
            new ListTile(
              title: new Text("Contact Us"),
              trailing: new Icon(Icons.contacts, color: Colors.blue,),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new contactPage())),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Sign Out"),
              trailing: new Icon(Icons.arrow_back, color: Colors.redAccent,),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HomePage())),
            ),

          ],
        ),
      ),

      body: new CourseList(users: usr),

        floatingActionButton:  FloatingActionButton.extended(
            backgroundColor: Colors.green,
            icon: Icon(Icons.add, color: Colors.white,),
            label: Text("Add Course"),
            onPressed: () => {
              print(usr.displayName),
              goToNewItemView(context)
            }
        ),
      ),


     

    );

  }


}



class Course{
  final String title;
  final String teacherName;

  Course({
    this.title,
    this.teacherName
  });
}

class CourseList extends StatelessWidget {
  CourseList({@required this.users});
  FirebaseUser users;
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('users').document(users.uid).snapshots(),
      builder: ( context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        else {
          var userDocument = snapshot.data;
          List<String> addedClass = List.from(userDocument["class"]);
          int numClasses = addedClass.length;

          return new ListView.builder(
            itemCount: numClasses,
            itemBuilder: (BuildContext context, int index){
             return Card(
               color: Colors.green,
               child: ListTile(
               title: Text(userDocument["class"][index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
               subtitle: Text(userDocument["teachers"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => DetailedView()))
             )

             );

            },
          );
        }
      },
    );
  }
}
