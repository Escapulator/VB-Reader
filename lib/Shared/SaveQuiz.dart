import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SaveQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
  child: Center(
    child: SpinKitFadingCircle(
      color: Colors.white,
      size: 400
    )
  )
      
    );
  }
}
