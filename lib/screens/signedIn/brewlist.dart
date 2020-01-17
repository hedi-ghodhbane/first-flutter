import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_app/models/brew.Dart';
import 'package:score_app/screens/signedIn/BrewTile.dart';
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    return ListView.builder(
      itemCount: brews != null ? brews.length : 0,
      itemBuilder: (context,index){
        return BrewTile(brew : brews[index]) ;
      },
    );
  }
}