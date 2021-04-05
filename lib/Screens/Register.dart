import 'package:flutter/material.dart';
import 'package:vb_reader/Authentication/Auth.dart';
import 'package:vb_reader/Shared/CustomButton.dart';
import 'package:vb_reader/Shared/Loading.dart';
import 'package:vb_reader/Shared/appBar.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  String name;
  String role;
  int score;

  Auth _auth = Auth();
  bool isLoading = false;
  bool passwordVisible;

  @override
  void initState() {
    passwordVisible = true;
  }

  signUp() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await _auth.signUp(email, password, name, role, score).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pushReplacementNamed('Home');
        }
        else{
          setState(() {
            isLoading = false;
          });
        }
      });
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
      body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * .9,
            child: Form(
          key: _formkey,
            child: Column(
              children: [
                Spacer(),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? 'Enter name' : null;
                  },
                  decoration: InputDecoration(hintText: 'Name'),
                  onChanged: (val) {
                    name = val;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
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
                ),DropdownButtonFormField(
                            decoration: InputDecoration( labelText: 'Role'),
                            value: role,
                            items: [
                              DropdownMenuItem(
                                child: Text("Coach"),
                                value: "Coach",
                              ),
                              DropdownMenuItem(child: Text("Player"), value: "Player"),
                            ],
                            validator: (input) =>
                                input == '' ? 'Please enter a Role' : null,
                            onSaved: (input) => role = input,
                            onChanged: (value) {
                              setState(() {
                                role = value;
                              });
                            }),
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
                            // Based on passwordVisible state choRolee the icon
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
                   await signUp();
                  },
                  child: customButton(context, 'Register')
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('Login');
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 16, decoration: TextDecoration.underline),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
