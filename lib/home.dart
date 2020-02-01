
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:communicationacademy/login.dart';
import 'package:communicationacademy/signup.dart';
import 'package:communicationacademy/card.dart';
import 'package:communicationacademy/app_card.dart';


class HomePage extends StatelessWidget{
  const HomePage({Key, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(bottom: 140.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            CircleAvatar(
              backgroundImage: AssetImage("assets/commLogo.png"),
              radius: 60,
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 50),
              textColor: Colors.black,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()
                    ));
              },
              child: TitleCard(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text("Login",
                        style: TextStyle(
                          fontSize: 28.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),

            FlatButton(
              padding: EdgeInsets.only(top: 20),
              textColor: Colors.black,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DropDown()
                    ));
              },
              child: TitleCard(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text("Sign Up",
                        style: TextStyle(
                          fontSize: 28.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),

          ],
        ),

      ),
    );
  }

}

//child: TitleCard(
//                child: Container(
//                  child: Column(
//                    children: <Widget>[
//
//                    ],
//                  ),
//                ),
//              ),

