import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vb_reader/Authentication/database.dart';
import 'package:vb_reader/Screens/PlayQuiz.dart';

class QuizTile extends StatefulWidget {
  final String imgurl;
  final String title;
  final String description;
  final String quizID;

  QuizTile(
      {@required this.description,
      @required this.imgurl,
      @required this.quizID,
      @required this.title});

  @override
  _QuizTileState createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  @override
  Widget build(BuildContext context) {

    DatabaseService _db = DatabaseService();
    final CollectionReference userdata = FirebaseFirestore.instance.collection('UserData');
    return GestureDetector(
      onLongPress: () async {
        var firebaseUser =  FirebaseAuth.instance.currentUser;
        await userdata.doc(firebaseUser.uid).get().then((docx){
           if(docx.data()['role'] == 'Coach'){
        _db.deleteQuiz(widget.quizID);}
            else{
              unAuthorized(context);
            print('Access Denied');
             }
        });},
      onTap: () {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => PlayQuiz(widget.quizID)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.imgurl,
                width: MediaQuery.of(context).size.width * 1,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(widget.description,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

     void unAuthorized(BuildContext context) {
    Fluttertoast.showToast(
        msg: "You are not authorized to create quizs",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).accentColor,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {});
  }
}
