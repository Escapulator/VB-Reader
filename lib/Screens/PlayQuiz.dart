import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vb_reader/Authentication/database.dart';
import 'package:vb_reader/Models/QuestionModel.dart';
import 'package:vb_reader/Screens/PlayQuizTile.dart';
import 'package:vb_reader/Screens/Results.dart';
import 'package:vb_reader/Shared/appBar.dart';

class PlayQuiz extends StatefulWidget {
  final String quizID;
  PlayQuiz(this.quizID);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int correct = 0;
int incorrect = 0;
int notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQNADisplayed(DocumentSnapshot qna) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = qna.data()['Question'];
    questionModel.videoUrl = qna.data()['videoUrl'];
    questionModel.stopAt = qna.data()['stopAt'];

    List<String> opts = [
      qna.data()['option1'],
      qna.data()['option2'],
      qna.data()['option3'],
    ];

    opts.shuffle();
    questionModel.option1 = opts[0];
    questionModel.option2 = opts[1];
    questionModel.option3 = opts[2];

    questionModel.correctAnswer = qna.data()['option1'];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print('${widget.quizID}');
    databaseService.getQuestions(widget.quizID).then((value) {
      setState(() {
        questionSnapshot = value;
        correct = 0;
        incorrect = 0;
        notAttempted = 0;
        total = questionSnapshot.docs.length;
        print('$total this is total');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (context) => Results(
                correct: correct,
                incorrect: incorrect,
                total: total,
              )));
        },
      ),
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: [
              questionSnapshot == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: questionSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return PlayQuizTile(
                          questionModel:
                              getQNADisplayed(questionSnapshot.docs[index]),
                          index: index,
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
