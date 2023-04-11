import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginform/colors.dart';
import 'package:http/http.dart' as http;
import 'package:loginform/home_screen.dart';
import 'package:loginform/loginScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  OtpVerificationPage(this.email);
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  String get email => widget.email;

  @override
  void initState() {
    super.initState();
  }

  Future<void> submit() async {
    try {
      final response = await http.post(
        'http://localhost:3000/email-verification',
        body: <String, String>{'email': email, 'otp': otp},
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
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  late String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: TextEditingController(text: otp),
                  onChanged: (value) {
                    otp = value;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    selectedColor: primaryColor,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: primaryColor,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  textStyle: TextStyle(fontSize: 20.0),
                  errorTextSpace: 16.0,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter OTP code';
                    }
                  },
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
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
                          submit();
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
