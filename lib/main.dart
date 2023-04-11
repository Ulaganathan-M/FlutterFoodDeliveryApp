import 'package:flutter/material.dart';
import 'package:loginform/constants.dart';
import 'package:loginform/home_screen.dart';
import 'accountActivate.dart';
import 'fogotPassword.dart';
import 'forgotpassOTP.dart';
import 'forgotpasswordChange.dart';
import 'loginScreen.dart';
import 'signup_screen.dart';

//lg8o5UPcuAUPJ4MY3plSqhRaR782
//flutter run --no-sound-null-safety
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      title: appName,
      debugShowCheckedModeBanner: false,
    );
  }
}
