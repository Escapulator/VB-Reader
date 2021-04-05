import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vb_reader/Authentication/database.dart';
import 'package:vb_reader/Screens/Videos.dart';
import 'package:vb_reader/Shared/SaveQuiz.dart';
import 'package:vb_reader/Shared/appBar.dart';
import 'package:video_player/video_player.dart';

class AddQuestions extends StatefulWidget {
  final String uid;
  AddQuestions(this.uid);
  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  String question;
  String option1;
  String option2;
  String option3;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File _video;
  String videoUrl;
  int stopAt;
  String y;

  DatabaseService _databaseService = DatabaseService();

  Future getVideo() async {
    setState(() {
      _video = null;
    });
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
    });
  }

  uploadQuestion() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      final StorageReference questionvideo =
          FirebaseStorage.instance.ref().child('Question Video');
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask = questionvideo
          .child(timeKey.toString() + '.mp4')
          .putFile(_video, StorageMetadata(contentType: 'video/mp4'));
      var urlVideo = await (await uploadTask.onComplete).ref.getDownloadURL();
      videoUrl = urlVideo.toString();
      Map<String, dynamic> questionMap = {
        'Question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'videoUrl': videoUrl,
        'stopAt': stopAt,
      };
      await _databaseService
          .addQuestionData(questionMap, widget.uid)
          .then((value) {
        setState(() {
          isLoading = false;
          _video = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SaveQuiz()
        : Scaffold(
            appBar: AppBar(
              title: appBar(context),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * .9,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * .8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: (_video != null)
                                  ? Video(
                                      videoPlayerController:
                                          VideoPlayerController.file(_video),
                                      looping: false,
                                    )
                                  : Image.asset('assets/logo.PNG'),
                            ),
                            MaterialButton(
                              color: Colors.grey[200],
                              elevation: 7,
                              child: Text(
                                'Select Video',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                getVideo();
                              },
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        validator: (val) =>
                            val.isEmpty ? 'Enter Question' : null,
                        decoration: InputDecoration(hintText: 'Question'),
                        onChanged: (val) {
                          question = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        validator: (val) => val.isEmpty ? 'Enter Option' : null,
                        decoration: InputDecoration(
                            hintText: 'Option1 (Correct Answer)'),
                        onChanged: (val) {
                          option1 = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        validator: (val) => val.isEmpty ? 'Enter Option' : null,
                        decoration: InputDecoration(hintText: 'Option2'),
                        onChanged: (val) {
                          option2 = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        validator: (val) => val.isEmpty ? 'Enter Option' : null,
                        decoration: InputDecoration(hintText: 'Option3'),
                        onChanged: (val) {
                          option3 = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        keyboardType: TextInputType.number,
                        validator: (val) => val.isEmpty ? 'set time' : null,
                        decoration: InputDecoration(hintText: 'Pause after'),
                        onChanged: (val) {
                          stopAt = int.parse(val);
                        },
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              child: Text('Submit'),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .4,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          GestureDetector(
                            onTap: () {
                              uploadQuestion();
                            },
                            child: Container(
                                child: Text('Add Question'),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * .4,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30))),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
