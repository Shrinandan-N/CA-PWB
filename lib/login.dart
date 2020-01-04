
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:communicationacademy/card.dart';
import 'package:communicationacademy/app_card.dart';
import 'package:communicationacademy/signup.dart';
import 'package:communicationacademy/home.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        body: Container(
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

    if(_formstate.validate()){
      _formstate.save();
      try {
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        print("logged in!");
        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomePage(user: user)));
      }catch(e){
        print(e.message);
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
    }

  }

}