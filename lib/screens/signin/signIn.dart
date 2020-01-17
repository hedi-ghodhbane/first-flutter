import 'package:flutter/material.dart';
import 'package:score_app/services/auth.dart';
import 'package:score_app/shared/decorations.dart';
import 'package:score_app/shared/loading.dart' ;
class SignIn extends StatefulWidget {
  final Function toggleView ;
  SignIn({this.toggleView}) ;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Auth _auth = Auth();
  bool isLoading = false ;
  String email ='' ;
  String error = '' ;
  String password='' ;
  final _formKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() :Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: (){
              print("pressed");
              widget.toggleView() ;
            },
          )
        ],
        backgroundColor: Colors.amber,
        title: Text("sign in"),
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
                decoration: myInputDecoration("Email") ,
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
                child: Text("Sign In",
                style: TextStyle(
                  color: Colors.white
                ),),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      isLoading = true ;
                    });
                    dynamic result = await _auth.signIn( email, password) ;
                    if(result==null){
                      setState(() {
                        error =" Your Email Or Password Are Not Correct" ;
                        isLoading = false ;
                      });
                    }
                  }
                  
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(error,style:TextStyle(
                color: Colors.red ,
                fontSize: 15.0
              ))
            ],
          ),
        ),
        ),
      );
  }
}