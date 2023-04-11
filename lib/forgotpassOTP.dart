import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loginform/colors.dart';
import 'package:http/http.dart' as http;
import 'package:loginform/loginScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'forgotpasswordChange.dart';

class ForgotPassOtpVerificationPage extends StatefulWidget {
  final String email;
  ForgotPassOtpVerificationPage(this.email);
  @override
  _ForgotPassOtpVerificationPageState createState() =>
      _ForgotPassOtpVerificationPageState();
}

class _ForgotPassOtpVerificationPageState
    extends State<ForgotPassOtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  String get email => widget.email;

  @override
  void initState() {
    super.initState();
  }

  Future<void> submit() async {
    try {
      final response = await http.post(
        'http://localhost:3000/otp-verification',
        body: <String, String>{'email': email, 'otp': otp},
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => passwordChange(email)),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 20),
                            child: Text(
                              "OTP Sent to ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 20),
                            child: Text(
                              "${email.substring(0, 3)}*****@${email.split('@')[1]}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 109, 166, 212),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
