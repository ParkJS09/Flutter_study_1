import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WelCome' + email),
        ),
        body: Container(
          child: FlatButton(onPressed: () {
            //LogOut
            FirebaseAuth.instance.signOut();
          },
          child: Text("Logout"),
          color: Colors.blue,),
        ));
  }
}
