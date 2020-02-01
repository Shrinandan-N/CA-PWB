
import 'package:communicationacademy/home.dart';
import 'package:communicationacademy/studentHome.dart';
import 'package:communicationacademy/teacherHome.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:communicationacademy/card.dart';
import 'package:communicationacademy/app_card.dart';
import 'package:communicationacademy/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicationacademy/teacherHome.dart';
import 'package:url_launcher/url_launcher.dart';

class DropDown extends StatefulWidget{
  DropDown() : super();

  @override
  SignUpPage createState() => SignUpPage();
}
class SignUpPage extends State<DropDown>{
  final mailText = TextEditingController();
  final pwdText = TextEditingController();
  final nameText = TextEditingController();
  final pemailText = TextEditingController();
  final classText = TextEditingController();
  final pnameText = TextEditingController();
  final formkey = new GlobalKey<FormState>();
  String _name;
  String _email;
  String _sp;
  String _password;
  String _pname;
  String _pemail;
  String _classes;
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
  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }else{
      print('ERROR');
    }
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
                        controller: nameText,
                        onSaved: (value) => _name= value,
                      ),
                      TextFormField(

                          decoration: InputDecoration(labelText: "Email"),
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please enter your email';
                            }
                          },
                          controller: mailText,
                          onSaved: (value) => _email= value
                      ),



                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                          controller: pwdText,
                          validator: (value) {
                            if(value.length < 6){
                              return 'Password needs to be atleast 6 characters';
                            }
                          },
                          onSaved: (value) => _password= value

                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Parent Name"),
                        validator: (value) {
                          if(value.isEmpty){
                            return 'Please enter your parent full name';
                          }
                        },
                        controller: pnameText,
                        onSaved: (value) => _pname= value,
                      ),
                      TextFormField(

                          decoration: InputDecoration(labelText: "Parent Email"),
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please enter your parent email';
                            }
                          },
                          controller: pemailText,
                          onSaved: (value) => _pemail= value
                      ),



                      TextFormField(
                          decoration: InputDecoration(labelText: "Classes Interested In Taking"),
                          controller: classText,
                          validator: (value) {
                            if(value.length < 6){
                              return 'Please mention atleast 1 class';
                            }
                          },
                          onSaved: (value) => _classes= value

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

  Future<String> getCurrentUid() async{
    return (await FirebaseAuth.instance.currentUser()).uid;
  }


  Future<void> signUp() async{


    final _formstate =  formkey.currentState;

    if(_formstate.validate()){
      _formstate.save();
//      customLaunch('mailto:emailckn@yahoo.com?subject=New%20Student%20Registration&'
//          'body=DO%20NOT%20EDIT%20THE%20FOLLOWING%20EMAIL%0D%0A'
//          '%0D%0AA%20New%20student%20has%20registered!%0D%0A%0D%0AHere%20is%20their%20information:'
//          '%0D%0AStudent%20Name:%20${nameText.text}%0D%0AStudent%20Email:%20${mailText.text}'
//          '%0D%0AParent%20Name:%20${pnameText.text}%0D%0AParent%20Email:%20${pemailText.text}'
//          '%0D%0AStudent%20Class%20Interests:%20${classText.text}%0D%0A'
//          '%0D%0AFrom,%0D%0AThe%20Communication%20Academy%20App%20Team');

      try {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);


        FirebaseUser user =  await result.user;

        final uid  = await getCurrentUid();

        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = nameText.text;
        result.user.updateProfile(updateInfo);
        user.reload();

        Firestore.instance.collection("users").document(uid).setData({  //maybe make document uid as well
          "name": nameText.text,
          "role": _selectedRole.role,
          "email": mailText.text,
          "parent name": pnameText.text,
          "parent email": pemailText.text,
          "interested classes": classText.text,
          "class" : FieldValue.arrayUnion([]),
          "teachers" : "No Teachers",

        });



        if(_selectedRole.role == 'Student') {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => StudentHomePage(user:
              user, displayName: nameText.text)));
        }else if(_selectedRole.role == 'Teacher'){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => TeacherHomePage(user: user)));
        }
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