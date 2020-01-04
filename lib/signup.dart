
import 'package:communicationacademy/home.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:communicationacademy/card.dart';
import 'package:communicationacademy/app_card.dart';
import 'package:communicationacademy/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DropDown extends StatefulWidget{
  DropDown() : super();

  @override
  SignUpPage createState() => SignUpPage();
}
class SignUpPage extends State<DropDown>{
  final mailText = TextEditingController;
  final pwdText = TextEditingController;

  final formkey = new GlobalKey<FormState>();
  String _name;
  String _email;
  String _sp;
  String _password;
  List<Roles> _roles = Roles.getRoles();
  List<DropdownMenuItem<Roles>> _dropdownmenuitem;
  Roles _selectedRole;

  @override
  void initState(){
    _dropdownmenuitem= buildDropdownMenuItems(_roles);
    _selectedRole = _dropdownmenuitem[0].value;
    super.initState();

  }

  List<DropdownMenuItem<Roles>> buildDropdownMenuItems(List role){
    List<DropdownMenuItem<Roles>> items= List();
    for(Roles roles in role){
      items.add(DropdownMenuItem(
          value: roles,
          child: Text(roles.role)
      ));
    }
    return items;
  }
  onChangeDropdownItem(Roles selectedRole){
    setState(() {
      _selectedRole = selectedRole;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
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
                      DropdownButton(
                        value: _selectedRole,
                        items: _dropdownmenuitem,
                        onChanged: onChangeDropdownItem,

                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Full Name"),
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Please enter your full name';
                          }
                        },
                        onSaved: (value) => _name= value,
                      ),
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
                            signUp();
                          },
                          child: Text("Sign Up"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have an Account?"),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()
                          )
                      );
                    },
                    child: Text("Login Here"),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async{
    final _formstate =  formkey.currentState;

    if(_formstate.validate()){
      _formstate.save();
      try {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;



        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentHomePage(user: user)));
      }catch(e){
        print(e.message);
      }
    }

  }

}

class Roles {
  int id;
  String role;

  Roles(this.id, this.role);

  static List<Roles> getRoles() {
    return <Roles>[
      Roles(0, 'Are you a Student or Teacher?'),
      Roles(1, 'Student'),
      Roles(1, 'Teacher')
    ];
  }



}