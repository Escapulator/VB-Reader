import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
        text: 'VB Reader',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue)),
  );
}
