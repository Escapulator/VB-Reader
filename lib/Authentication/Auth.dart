import 'package:firebase_auth/firebase_auth.dart';
import 'package:vb_reader/Authentication/UserData.dart';
import 'package:vb_reader/Models/User.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userModel(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

    Stream<UserModel> get state {
    return _auth.authStateChanges().map(_userModel);
  }



  Future signIn(String email, String password) async {
    try {
      UserCredential rslt = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = rslt.user;
      return _userModel(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUp(String email, String password, String name, String role, int score) async {
    try {
      UserCredential rslt = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = rslt.user;
      await UserData(uid: firebaseUser.uid).createUser(name, role, 0);
      return _userModel(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
