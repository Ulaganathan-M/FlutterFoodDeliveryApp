import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginform/colors.dart';
import 'package:loginform/home_screen.dart';
import 'package:loginform/loginScreen.dart';
import 'constants.dart';
import 'forgotpassOTP.dart';
import 'signup_screen.dart';
import 'package:http/http.dart' as http;

class forgotPassword extends StatefulWidget {
  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> sendOTP(BuildContext context) async {
    try {
      final response = await http.post(
        'http://localhost:3000/forgot',
        body: <String, String>{
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        final Message = json.decode(response.body)['success'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Message),
            backgroundColor: Colors.green,
          ),
        );
        final userEmail = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPassOtpVerificationPage(email)),
        );
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final errorMessage = json.decode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Error occurred: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  late String email = '';
  late String password = '';
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Container(
                    child: Text(
                      "Enter Your Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: TextEditingController(text: email),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Email";
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) return "It is not a valid Email";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                      labelText: "Email Address",
                      labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                        child: Text("Send OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            sendOTP(context);
                          } else {
                            print("not ok");
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Go to login",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
