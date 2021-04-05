import 'package:flutter/material.dart';
import 'package:vb_reader/Models/QuestionModel.dart';
import 'package:vb_reader/Screens/Options.dart';
import 'package:vb_reader/Screens/PlayQuiz.dart';
import 'package:vb_reader/Screens/Videos.dart';
import 'package:video_player/video_player.dart';

class PlayQuizTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  PlayQuizTile({this.questionModel, this.index});
  @override
  _PlayQuizTileState createState() => _PlayQuizTileState();
}

class _PlayQuizTileState extends State<PlayQuizTile> {
  String optionSelected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
                ('Q${widget.index + 1} ' + widget.questionModel.question),
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
              ),
          Stack(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Video(
                  videoPlayerController:
                      VideoPlayerController.network(widget.questionModel.videoUrl),
                      stopAt: Duration(seconds: widget.questionModel.stopAt),
                      //stopAt: Duration(seconds: widget.questionModel.stopAt.toInt()),
                      looping: false,
                      ), 
            
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                          child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!widget.questionModel.answered) {
                          if (widget.questionModel.option1 ==
                              widget.questionModel.correctAnswer) {
                            optionSelected = widget.questionModel.option1;
                            widget.questionModel.answered = true;
                            correct = correct + 1;
                            notAttempted = notAttempted - 1;
                            setState(() {});
                          } else {
                            optionSelected = widget.questionModel.option1;
                            widget.questionModel.answered = true;
                            incorrect = incorrect + 1;
                            notAttempted = notAttempted - 1;
                            setState(() {});
                          }
                        }
                      },
                      child: Options(
                          desc: widget.questionModel.option1,
                          correctAnsa: widget.questionModel.correctAnswer,
                          option: 'A',
                          selected: optionSelected),
                    ),
                    SizedBox(
                  width: MediaQuery.of(context).size.width * .02,
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      if (widget.questionModel.option2 ==
                          widget.questionModel.correctAnswer) {
                        optionSelected = widget.questionModel.option2;
                        widget.questionModel.answered = true;
                        correct = correct + 1;
                        notAttempted = notAttempted - 1;
                        setState(() {});
                      } else {
                        optionSelected = widget.questionModel.option2;
                        widget.questionModel.answered = true;
                        incorrect = incorrect + 1;
                        notAttempted = notAttempted - 1;
                        setState(() {});
                      }
                    }
                  },
                  child: Options(
                      desc: widget.questionModel.option2,
                      correctAnsa: widget.questionModel.correctAnswer,
                      option: 'B',
                      selected: optionSelected),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .02,
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      if (widget.questionModel.option3 ==
                          widget.questionModel.correctAnswer) {
                        optionSelected = widget.questionModel.option3;
                        widget.questionModel.answered = true;
                        correct = correct + 1;
                        notAttempted = notAttempted - 1;
                        setState(() {});
                      } else {
                        optionSelected = widget.questionModel.option3;
                        widget.questionModel.answered = true;
                        incorrect = incorrect + 1;
                        notAttempted = notAttempted - 1;
                        setState(() {});
                      }
                    }
                  },
                  child: Options(
                      desc: widget.questionModel.option3,
                      correctAnsa: widget.questionModel.correctAnswer,
                      option: 'C',
                      selected: optionSelected),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .02,
                ),

                  ],
                ),
              ),
                      ],
          ),
        ],
      ),
    );
  }
}
