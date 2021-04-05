import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vb_reader/Authentication/database.dart';
import 'package:vb_reader/Screens/LeaderBoardTile.dart';
import 'package:vb_reader/Shared/appBar.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  DatabaseService _databaseService = DatabaseService();

  Stream scoreStream;

  Widget scoreboard() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('UserData').where('score', isGreaterThanOrEqualTo: 1)
            .orderBy('score', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height * .86,
                  child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.documents[index]),
                  ),
                );
        },
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    return LeaderBoardTile(
      name: document.data()['name'],
      score: document.data()['score'],
    );
  }

  @override
  void initState() {
    _databaseService.getQuizData().then((val) {
      setState(() {
        scoreStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Score',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            Divider(height: 3,
            thickness: 3,
            color: Colors.black,),
            scoreboard(),
          ],
        ),
      ),
    );
  }
}
