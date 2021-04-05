import 'package:flutter/material.dart';
import 'package:vb_reader/Screens/Login.dart';
import 'package:vb_reader/Screens/Register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;
  void getscreen () {
    setState(() {
      signIn = !signIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (signIn){
      return Login();
    }else{
      return Register();
    }
  }
}