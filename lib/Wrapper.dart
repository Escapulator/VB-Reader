import 'package:provider/provider.dart';
import 'package:vb_reader/Models/User.dart';
import 'package:vb_reader/Screens/Home.dart';
import 'package:vb_reader/Screens/authenticate.dart';

import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
   if (user == null){
     return Authenticate();
   }else{
     return Home();
   }
  }
}