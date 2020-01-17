import 'package:flutter/material.dart';
import 'package:score_app/screens/signin/Register.dart';
import 'package:score_app/screens/signin/signIn.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool _signIn = true ;
  void toggleView(){
    print("hello from toggleView");
    setState(() {
      _signIn = !_signIn ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return _signIn ? SignIn(toggleView : toggleView) : Register(toggleView : toggleView) ; 
  }
}