import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginform/colors.dart';
import 'package:loginform/loginScreen.dart';
import 'accountActivate.dart';
import 'constants.dart';
import 'user.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> save(BuildContext context) async {
    try {
      final response = await http.post(
        'http://localhost:3000/signup',
        body: <String, String>{
          'name': name,
          'email': email,
          'password': password,
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpVerificationPage(email)),
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
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  // User user = User('', '', '', '');
  late String name = '';
  late String email = '';
  late String password = '';
  late String confirm_password = '';
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                Stack(
                  children: <Widget>[
                    Image.asset(
                      bgimage,
                      height: height * 0.40,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * 0.42,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            stops: [0.3, 0.95],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.white]),
                      ),
                      // color: Colors.yellow.withOpacity(0.3),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    appName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
                Center(
                  child: Text(slogan, style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Container(
                    child: Text(
                      "  $signupString  ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: primaryColor, width: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Name";
                      }
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.supervisor_account,
                          color: primaryColor,
                        ),
                        labelText: "Username",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        labelText: "Email Address",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: TextEditingController(text: password),
                        onChanged: (value) {
                          password = value;
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
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: primaryColor, fontSize: 16),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: TextEditingController(text: confirm_password),
                    onChanged: (value) {
                      confirm_password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Confirm-Password";
                      } else if (password != confirm_password) {
                        return "Password dosn't Match";
                      } else {}
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      prefixIcon: Icon(
                        Icons.lock_open,
                        color: primaryColor,
                      ),
                      labelText: "Confirm Password",
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
                        child: Text("Register account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            save(context);
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
                    Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
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
                        "Login",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
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
