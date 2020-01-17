import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:score_app/models/brew.Dart';
import 'package:score_app/models/userData.dart';


class DataBaseService{
  final String uid ;
  DataBaseService({this.uid});
  //collection reference 
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  
  List<Brew> _listBrewsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      print(doc.data['name']);
      

      return 
        Brew(
        sugar : doc.data['sugar'] ?? '0' ,
        strength : doc.data['strength'] ?? 0 ,
        name : doc.data['name'] ?? ''  ) ;
    }).toList() ;
  } 
  UserData _toUserData(DocumentSnapshot snapshot){
    return  UserData(
      uid : uid ,
      name: snapshot.data['name'] ?? '' ,
      strength: snapshot.data['strength'] ?? '100' ,
      sugar: snapshot.data['sugar'] ?? '0'
    );
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_toUserData);
  }
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_listBrewsFromSnapshot) ; 
  }
  Future<void> updateData(String sugar , String name , int strength){
     brewCollection.document(uid).setData({
      'sugar' : sugar ,
      'name' : name ,
      'strength' : strength
    }) ;
    } 
}