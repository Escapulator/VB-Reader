import 'package:flutter/material.dart';

Widget customButton(BuildContext context, String label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.circular(20),
    ),
    width: MediaQuery.of(context).size.width * .9,
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
          color: Colors.grey[100], fontSize: 18, fontWeight: FontWeight.w700),
    ),
  );
}
