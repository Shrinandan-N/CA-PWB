


import 'package:communicationacademy/teacherHome.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:communicationacademy/card.dart';
import 'package:communicationacademy/app_card.dart';
import 'package:communicationacademy/signup.dart';
import 'package:communicationacademy/home.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginPage extends StatelessWidget{

  final formkey = new GlobalKey<FormState>();
  String _email;
  String _password;


  @override
  Widget build(BuildContext context) {
    var pwdText = TextEditingController();
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleCard(
                  child: Text("Communication Academy",
                    style: TextStyle(fontSize: 32.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppCard(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        TextFormField(

                            decoration: InputDecoration(labelText: "Email"),
                            validator: (value) {
                              if(value.isEmpty){
                                return 'Please enter your email';
                              }
                            },
                            onSaved: (value) => _email= value
                        ),
                        TextFormField(
                            controller: pwdText,
                            obscureText: true,
                            decoration: InputDecoration(labelText: "Password"),
                            validator: (value) {
                              if(value.length < 6){
                                return 'Password needs to be atleast 6 characters';
                              }
                            },
                            onSaved: (value) => _password= value
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            onPressed: (){
                              signIn(context);
                            },
                            child: Text("Login"),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(top: 15.0),
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: (){},
                            child: Text("Forgot Password?"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    FlatButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DropDown()
                            )
                        );
                      },
                      child: Text("Sign up Here"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    FlatButton(
                      child: Text("Go back Home"),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()
                            )
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }


  Future<void> signIn(context) async{
    final _formstate =  formkey.currentState;
    final databaseReference = Firestore.instance;

    if(_formstate.validate()){
      _formstate.save();
      try {

        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;

        Firestore.instance
            .collection('users')
            .document(user.uid)
            .get()
            .then((DocumentSnapshot ds) {

              print(ds.data['role'].toString());

              if(ds.data['role'].toString() == "Teacher"){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherHomePage(user: user)));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomePage(user: user, displayName: ds.data['name'].toString(),)));
              }
        });


        print("logged in!");




//create a new method that returns role of current user that is referenced in this method to validate whether role matches "student" or "teacher"

      }catch(e){
        print(e);
        AlertDialog dialog = new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(15.0))),
          title: Text("Email or Password not recognized",
            style: TextStyle(fontSize: 20.0),),
          content: new Container(
            width: 5.0,
            height: 5.0,
          ),
          actions: <Widget>[
            new FlatButton(onPressed: () {
              Navigator.pop(context);
            },
                child: new Text("Ok",
                  style: TextStyle(fontSize: 20.0),))
          ],

        );

        showDialog(context: context, child: dialog);
      }
    }else{
      print("User could not be logged in");
    }

  }



}


//        AsyncSnapshot asyncSnapshot =  await databaseReference.collection("users").document("user information").collection(user.uid).document();
//        DocumentSnapshot ds = asyncSnapshot.data.documents["role"];
//         StreamBuilder(
//
//          stream: Firestore.instance.collection("users").document("user information").collection(user.uid).snapshots(),
//          builder: (BuildContext  context,AsyncSnapshot snapshot) {
//            if (snapshot.hasData) {
//              itemBuilder:
//                  (context, index) {
//                DocumentSnapshot ds = snapshot.data.documents[index];
//                if(ds["role"] == "student"){
//                  print("yes");
//                }else{
//                  print("no");
//                }
//              };
//            }else{
//              print("no");
//            }
//          }
//
//        );