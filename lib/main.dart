import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auths/data/join_or_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screense/Login.dart';
import 'Screense/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          //data is FirebaseUser
          if (snapshot.data == null) {
            //Login이 안된상태
            return ChangeNotifierProvider<JoinOrLogin>.value(
                child: AuthPage(),
                value: JoinOrLogin());
          }else {
            return MainPage(email:snapshot.data.email);
          }
        }
    );
  }
}

