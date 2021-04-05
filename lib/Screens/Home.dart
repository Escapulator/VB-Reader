import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vb_reader/Authentication/Auth.dart';
import 'package:vb_reader/Authentication/database.dart';
import 'package:vb_reader/Screens/QuizTile.dart';
import 'package:vb_reader/Shared/appBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth _auth = Auth();
  DatabaseService _databaseService = DatabaseService();
  
  final CollectionReference userdata = FirebaseFirestore.instance.collection('UserData');

  Stream quizStream;

  Widget quizList() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Quiz').snapshots(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
                );
        },
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    return QuizTile(
      quizID: document.data()['quizID'],
      imgurl: document.data()['imageUrl'],
      title: document.data()['title'],
      description: document.data()['description'],
    );
  }

  @override
  void initState() {
    _databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
        onPressed: () async {
        var firebaseUser =  FirebaseAuth.instance.currentUser;
        await userdata.doc(firebaseUser.uid).get().then((docx){
           if(docx.data()['role'] == 'Coach'){
             Navigator.of(context).pushNamed('New Quiz');}
            else{
              unAuthorized(context);
            print('Access Denied');
             }
        });}
      ),
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        elevation: 0,
        actions: [
          FlatButton(
            child: Text('Sign Out'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton(
            child: Text('ScoreBoard'),
            onPressed: () {
              Navigator.of(context).pushNamed('Leader');
            },
          ),
        ],
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
      ),
      body: quizList(),
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
