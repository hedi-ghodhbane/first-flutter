


import 'package:flutter/material.dart';
import 'package:score_app/services/auth.dart';
import 'package:score_app/shared/loading.dart';
import 'package:score_app/screens/signedIn/settingsFrom.dart';
import 'package:score_app/models/brew.Dart';
import 'package:score_app/services/db.dart';
import 'package:provider/provider.dart';
import 'package:score_app/screens/signedIn/brewlist.dart';

class Dashbord extends StatefulWidget {
  @override
  _DashbordState createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  final Auth _auth = Auth();
  bool isLoading = false ;
  @override
  Widget build(BuildContext context) {
     void _showSettingsPanel(){
       showModalBottomSheet(context: context , builder: (context){
         return Container(
           padding: EdgeInsets.all(8.0),
           child: SettingsForm(),
         );
       });
     }
    return  isLoading ? Loading() :StreamProvider<List<Brew>>.value(
      value : DataBaseService().brews ,
        child: Scaffold(
        appBar: AppBar(
          title: Text("dashbord"),
          backgroundColor: Colors.amber,
          actions: <Widget>[
         
               FlatButton.icon(
                icon: Icon(
                  Icons.settings ,
                ),
                label: Text("Settings"),
                onPressed: ()=>_showSettingsPanel(),
              ),
            
            
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("log out"),
                onPressed: () async {
                  setState(() {
                    isLoading=true ;
                  });
                  return await _auth.signOut() ;
                },
              )
          ],
        ),
        body : BrewList(),
      ),
    );
  }
}