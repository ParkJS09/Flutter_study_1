import 'package:flutter/material.dart';

import 'Screense/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthPage());
  }
}
