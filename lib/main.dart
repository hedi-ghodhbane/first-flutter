import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_app/models/userModel.dart';
import 'package:score_app/screens/wrapper.dart';
import 'package:score_app/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: Auth().user,
      child : MaterialApp(
        home: Wrapper()),
    );
  }
}
