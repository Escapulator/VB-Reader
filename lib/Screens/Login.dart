import 'package:flutter/material.dart';
import 'package:vb_reader/Authentication/Auth.dart';
import 'package:vb_reader/Shared/CustomButton.dart';
import 'package:vb_reader/Shared/Loading.dart';
import 'package:vb_reader/Shared/appBar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  Auth _auth = Auth();
  bool isLoading = false; 
  bool passwordVisible;

  @override
  void initState() {
    passwordVisible = true;
  }

  signIn() async {
    if(_formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      await _auth.signIn(email, password).then((value) {if(value != null){
      Navigator.of(context).pushReplacementNamed('Home');
      setState(() {
        isLoading = false;
      });
      }});
    }
  }
  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        title: appBar(context),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  return val.isEmpty ? 'Enter email' : null;
                },
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              TextFormField(
                obscureText: passwordVisible,
                validator: (val) {
                  return val.isEmpty ? 'Enter password' : null;
                },
                decoration: InputDecoration(hintText: 'password',
                suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[900],
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),),
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              GestureDetector(
                onTap: () async {
                 await signIn();
                },
                              child: customButton(context, 'Sign In')
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(' Don\'t have an account yet?', style: TextStyle(fontSize: 16),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed('Register');
                  },
                  child: Text('Register', style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),))
              ],),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              )
            ],
          ),
        ),
      ),
    );
  }
}
