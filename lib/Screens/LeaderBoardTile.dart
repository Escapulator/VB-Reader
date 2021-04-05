import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderBoardTile extends StatelessWidget {
  final String name;
  final int score;


  LeaderBoardTile(
      {@required this.score,
      @required this.name,});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      Text(score.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
    ],),);
  }
}
