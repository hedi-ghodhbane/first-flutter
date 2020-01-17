



import 'package:firebase_auth/firebase_auth.dart';
import 'package:score_app/models/userModel.dart';
import 'package:score_app/services/db.dart';
class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance ;
  UserModel _createUser(FirebaseUser user){
    return user != null ? UserModel(uid: user.uid) : null ;
  }
  Stream<UserModel> get user {
    print(" heloooooooooooooo ${_auth.onAuthStateChanged
           } ");
           print("jklklkll");
    return _auth.onAuthStateChanged
           //.map((FirebaseUser user)=>_createUser(user));
           .map(_createUser);
  }
  Future registerWithEmailAndPassword(String email,String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email : email,password:password) ;
      FirebaseUser user = result.user ;
      DataBaseService(uid:user.uid).updateData('0', 'new brew', 100);
      return _createUser(user);

    } catch(e){
      print(e.toString());
      return null ;
    }
  }
  Future signOut() async {
    try {
      return await _auth.signOut() ;
    } catch(e){
      return null ;
    }
  }
  Future signIn(String email , String password) async {
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(email:email,password:password ) ;
        FirebaseUser user = result.user ;
        return _createUser(user) ;

      } catch(e){
        print(e.toString());
        return null ;
      }
  }
}