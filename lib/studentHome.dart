import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class StudentHomePage extends StatelessWidget {
  const StudentHomePage({Key key, @required this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home ${user.email}"),
        automaticallyImplyLeading: false,
      ),

    );
  }
}
