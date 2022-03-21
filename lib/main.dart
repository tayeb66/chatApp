import 'package:chatapp/chatScreen_page.dart';
import 'package:chatapp/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// it save user info
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null? LoginPage() : ChatScreenPage(),
  ));
}