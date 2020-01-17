import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_app/models/userData.dart';
import 'package:score_app/models/userModel.dart';
import 'package:score_app/services/auth.dart';
import 'package:score_app/services/db.dart';
import 'package:score_app/shared/decorations.dart';
import 'package:score_app/shared/loading.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>() ;
   String _currentName  ;
   String _currentSugar  ;
   int _currentStrength;
  final List<String> sugars = ['0','1','2','3','4'] ;
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<UserModel>(context) ;
    return StreamBuilder<UserData>(
         stream : DataBaseService(uid : user.uid ).userData ,
          builder :(context,snapshot){
          if(snapshot.hasData){
            UserData currentUser = snapshot.data ;
            return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
             Text("Upgrade Your Brew",
             style: TextStyle(
               fontSize: 30.0
             ),
             ),
             SizedBox(height: 20.0),
             TextFormField(
               initialValue: currentUser.name ,
               decoration: myInputDecoration("name").copyWith(hintStyle: TextStyle(
                 color: Colors.amberAccent
               )),
               style: TextStyle(
                 color: Colors.amberAccent
               ),
               validator: (val)=>val.isEmpty ? "please enter name " : null,
               onChanged: (val){
                 setState(() {
                   _currentName = val ;
                 });
               },
             ),
             SizedBox(height: 20.0,),
             DropdownButtonFormField(
               value: _currentSugar ?? currentUser.sugar ,
               icon: Icon(Icons.arrow_drop_down),
               iconEnabledColor: Colors.amber,
               decoration: myInputDecoration(""),
               items : sugars.map((sugar){
                  return DropdownMenuItem(
                    value: sugar ,
                    child: Text("$sugar sugar(s)",
                    style: TextStyle(
                      color: Colors.amber[300]
                    ),),
                  ) ;
               }).toList(),
               onChanged: (val){
                 setState((){
                   _currentSugar=val ;
                 });
               }
             ),
             SizedBox(height: 20.0,),
             Slider(
               activeColor: Colors.red[_currentStrength],
               inactiveColor: Colors.red[_currentStrength],
               value: (_currentStrength ?? currentUser.strength).toDouble(),
               min: 100,
               max: 900,
               divisions: 8,
               onChanged: (val){
                 setState(() {
                   _currentStrength = val.round() ;
                 });
               },
             ),
             SizedBox(height: 20.0,),
             
             //s
             //s
             RaisedButton(
               color : Colors.black,
               child: Text("Upgrade",
               style: TextStyle(
                 color: Colors.amberAccent
               ),),
               onPressed: () async {
                 if(_formKey.currentState.validate())
                 {await DataBaseService(uid:user.uid).updateData(_currentSugar, _currentName, _currentStrength) ;
                  Navigator.pop(context);
                 }
               } ,
             )
          ],),
          
        ),
      );
          } else {
            Loading() ;
          }
          }
    );
  }
}