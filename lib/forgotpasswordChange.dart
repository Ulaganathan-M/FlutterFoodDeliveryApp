import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginform/colors.dart';
import 'package:loginform/home_screen.dart';
import 'package:loginform/loginScreen.dart';
import 'constants.dart';
import 'forgotpassOTP.dart';
import 'signup_screen.dart';
import 'package:http/http.dart' as http;

class passwordChange extends StatefulWidget {
  final String email;
  passwordChange(this.email);
  @override
  State<passwordChange> createState() => _passwordChangeState();
}

class _passwordChangeState extends State<passwordChange> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String get email => widget.email;

  @override
  void initState() {
    super.initState();
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      final response = await http.post(
        'http://localhost:3000/password-change',
        body: <String, String>{
          'email': email,
          'new_password': new_password,
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
          MaterialPageRoute(builder: (context) => LoginScreen()),
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

  late String new_password = '';
  late String confirm_password = '';

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
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
                      "New Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: TextEditingController(text: new_password),
                        onChanged: (value) {
                          new_password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else if (!RegExp(
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
                              .hasMatch(value)) return "Not a valid Password";
                        },
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Container(
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      TextFormField(
                        controller:
                            TextEditingController(text: confirm_password),
                        onChanged: (value) {
                          confirm_password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Confirm-Password";
                          } else if (new_password != confirm_password) {
                            return "Password dosn't Match";
                          } else {}
                        },
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
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
                        child: Text("Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            changePassword(context);
                          } else {
                            print("not ok");
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
