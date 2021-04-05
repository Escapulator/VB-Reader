import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vb_reader/Authentication/Auth.dart';
import 'package:vb_reader/Models/User.dart';
import 'package:vb_reader/Screens/Home.dart';
import 'package:vb_reader/Screens/Leaderboard.dart';
import 'package:vb_reader/Screens/Login.dart';
import 'package:vb_reader/Screens/NewQuiz.dart';
import 'package:vb_reader/Screens/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vb_reader/Splash.dart';
import 'package:vb_reader/Wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel>.value(
          value: Auth().state,
        )
      ],
          child: MaterialApp(
        title: 'VB Reader',
        debugShowCheckedModeBanner: false,
        home: Splash(),
        routes: {
          'Login': (BuildContext context) => new Login(),
          'Register': (BuildContext context) => new Register(),
          'Home' : (BuildContext context) => new Home(),
          'New Quiz': (BuildContext context) => new NewQuiz(),
          'Wrapper' : (BuildContext context) => new Wrapper(),
          'Leader' : (BuildContext context) => new LeaderBoard(),
        },
      ),
    );
  }
}