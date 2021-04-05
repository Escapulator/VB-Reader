import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:vb_reader/Authentication/database.dart';
import 'package:vb_reader/Screens/AddQuestions.dart';
import 'package:vb_reader/Shared/CustomButton.dart';
import 'package:vb_reader/Shared/SaveQuiz.dart';
import 'package:vb_reader/Shared/appBar.dart';

class NewQuiz extends StatefulWidget {
  @override
  _NewQuizState createState() => _NewQuizState();
}

class _NewQuizState extends State<NewQuiz> {
  String title;
  String desc;
  String uid;
  final _formkey = GlobalKey<FormState>();
  DatabaseService _databaseService = DatabaseService();
  bool isLoading = false;
  File _image;
  String urlImage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  createQuiz() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      final StorageReference quizImage =
          FirebaseStorage.instance.ref().child('Quiz Image');
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
          quizImage.child(timeKey.toString() + '.jpg').putFile(_image);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      urlImage = imageUrl.toString();
      uid = randomAlphaNumeric(12);
      Map<String, String> addQuiz = {
        'quizID': uid,
        'title': title,
        'description': desc,
        'imageUrl': urlImage,
      };
      _databaseService.createQuiz(addQuiz, uid).then((value) {
        setState(() {
          isLoading = true;
        });
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => AddQuestions(uid)));
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
              centerTitle: true,
              elevation: 0,
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * .9,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .4,
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: (_image != null)
                                  ? Image.file(_image)
                                  : Image.asset('assets/logo.PNG'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: MaterialButton(
                                color: Colors.grey[200],
                                elevation: 7,
                                child: Text('Select Quiz Picture', style: TextStyle(fontSize: 15),),
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter Title' : null,
                        decoration: InputDecoration(hintText: 'Quiz Title'),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter Description' : null,
                        decoration:
                            InputDecoration(hintText: 'Quiz Description'),
                        onChanged: (val) {
                          desc = val;
                        },
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            createQuiz();
                          },
                          child: customButton(context, 'Create Quiz')),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
