import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData{

  final String uid;
  UserData({this.uid});

  final CollectionReference userdata = FirebaseFirestore.instance.collection('UserData');

  Future createUser(String name, String role, int score) async {
    return await userdata.doc(uid).set({
      'name' : name,
      'role' : role,
      'score' : score,
    });
  }
  updateScore(int score) async {
        var firebaseUser =  FirebaseAuth.instance.currentUser;
        userdata
        .doc(firebaseUser.uid)
        .update({'score': score,});
  }

  getScore() async {
        var firebaseUser =  FirebaseAuth.instance.currentUser;
        userdata
        .doc(firebaseUser.uid)
        .snapshots();
  }
}