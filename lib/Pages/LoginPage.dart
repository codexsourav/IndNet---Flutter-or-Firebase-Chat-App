import 'package:flutter/material.dart';

import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/Components/MyInput.dart';
import 'package:flutter_application_1/Pages/OtpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController mobileNumber = TextEditingController();
  String error = "";
  bool loading = false;

  void handelSendOtp() async {
    String mobile = mobileNumber.text;
    if (mobile.isEmpty) {
      setState(() {
        error = "Please Enter Your Mobile Number";
      });
    } else if (mobile.length != 10) {
      setState(() {
        error = "Inalid Mobile Number";
      });
    } else {
      setState(() {
        loading = true;
        error = "";
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$mobile',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            loading = false;
          });
          if (e.code == 'invalid-phone-number') {
            setState(() {
              error = "Invalid Mobile Number";
            });
          } else if (e.code == 'ERROR_TOO_MANY_REQUESTS') {
            setState(() {
              error = "Too many requests. Try again later.";
            });
          } else {
            setState(() {
              error = e.code;
            });
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OtpPage(
                  otpKey: verificationId,
                  mobileNumber: mobile,
                  resendOtpToken: resendToken)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80.0),
                  Image.asset('assets/splash.png', height: 200.0),
                  SizedBox(height: 60.0),
                  MyInput(
                      controller: mobileNumber,
                      prefixText: "+91 ",
                      onChanged: (val) {
                        setState(() {
                          if (error.isNotEmpty) {
                            error = "";
                          }
                        });
                      },
                      hintText: "Enter Mobile Number",
                      icon: Icon(
                        Icons.call,
                        color: Color.fromARGB(255, 31, 31, 31),
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          child: Text(
                            "$error",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 13),
                          ))),
                  const SizedBox(height: 20.0),
                  MyButton(
                      name: loading
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Send OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                      ontap: handelSendOtp,
                      color: loading
                          ? Color.fromARGB(255, 53, 53, 53)
                          : Color.fromARGB(255, 0, 0, 0),
                      desabl: loading)
                ]),
          ),
        ),
      ),
    );
  }
}
