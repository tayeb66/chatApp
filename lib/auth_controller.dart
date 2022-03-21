import 'package:chatapp/chatScreen_page.dart';
import 'package:chatapp/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signInWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? user = result.user;
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreenPage()));
    }
  }

  void register(context, String email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      catchError(context, e);
    }
  }

  void loginUser(context, String email, password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreenPage()));
    } catch (e) {
      catchError(context, e);
    }
  }

  void signOut(context) async {
    try {
      await firebaseAuth.signOut().then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false));
    } catch (e) {
      catchError(context, e);
    }
  }

  void catchError(context, e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error message'),
          content: Text(e.toString().trim()),
        ));
  }
}