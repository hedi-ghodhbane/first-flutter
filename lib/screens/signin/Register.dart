import 'package:flutter/material.dart';
import 'package:score_app/services/auth.dart';
import 'package:score_app/shared/decorations.dart';
import 'package:score_app/shared/loading.dart';
class Register extends StatefulWidget {
  final Function toggleView ;
  Register({this.toggleView}) ;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Auth _auth = Auth();
  String email ='' ;
  String password='' ;
  String error = '' ;
  bool isLoading = false ;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: (){
              print("pressed");
              widget.toggleView() ;
            },
          )
        ],
        backgroundColor: Colors.amber,
        title: Text("Register "),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child : Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                style: myTextStyle,
                decoration: myInputDecoration("Email"),
                validator: (val) => val.isEmpty ? 'Enter An Email' : null  ,
                onChanged: (val){
                  setState(() {
                    email = val ;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: myTextStyle,
                decoration: myInputDecoration("Password"),
                validator: (val) => val.length < 6 ? 'Enter A Password 6+ chars' : null  ,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val ;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.black,
                child: Text("Register ",
                style: TextStyle(
                  color: Colors.white
                ),),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true ;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password) ;
                    if(result==null){
                      setState(() {
                        isLoading=false ;
                        error = "Please Supply A Valid Email" ;
                      });
                    }
                  }
                  
                },
              ),
              SizedBox(height: 20.0,),
              Text(error,
              style:TextStyle(color:Colors.redAccent,fontSize: 15.0))
            ],
          ),
        ),
        ),
      );
  }
}