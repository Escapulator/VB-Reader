import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), (){Navigator.of(context).pushReplacementNamed('Wrapper');});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/splash.PNG', fit: BoxFit.cover,));
  }
}