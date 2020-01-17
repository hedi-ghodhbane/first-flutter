import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_app/models/userModel.dart';
import 'package:score_app/screens/signedIn/dashbord.dart';
import 'package:score_app/screens/signin/authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return  user == null ? Authentication() : Dashbord() ;
  }
}