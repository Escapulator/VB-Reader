import 'package:flutter/material.dart';
import 'package:vb_reader/Authentication/UserData.dart';
import 'package:vb_reader/Screens/PlayQuiz.dart';
import 'package:vb_reader/Shared/CustomButton.dart';
import 'package:vb_reader/Shared/appBar.dart';

class Results extends StatefulWidget {
  final int correct;
  final int incorrect;
  final int total;
  Results(
      {@required this.correct, @required this.incorrect, @required this.total});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  UserData _data = UserData();



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Score is ${widget.correct}/${widget.total}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'You answered ' + widget.correct.toString() + ' questions correctly',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03,),
            GestureDetector(onTap: (){
              _data.updateScore(total);
              //Here add the score to the database score
              Navigator.of(context).pop();},
            child: customButton(context, 'Go Home'),)
          ],
        ),
      )),
    );
  }
}
