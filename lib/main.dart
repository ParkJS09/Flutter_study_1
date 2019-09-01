import 'package:firebase_auth/data/join_or_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screense/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<JoinOrLogin>.value(
      child: AuthPage(),
      value: JoinOrLogin(),
    ));
  }
}
