import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> createQuiz(Map quizdata, String quizID) async {
    await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizID)
        .set(quizdata)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questions, String quizID) async {
    await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizID)
        .collection('QNA')
        .add(questions)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return FirebaseFirestore.instance.collection('Quiz').snapshots();
  }

  getQuestions(String uid) async {
    return await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(uid)
        .collection('QNA')
        .get();
  }

  getScore() async {
    return FirebaseFirestore.instance.collection('UserData').snapshots();
  }

  deleteQuiz(String uid) async {
    print('delete');
    return FirebaseFirestore.instance.collection('Quiz').doc(uid).delete();
  }
}
