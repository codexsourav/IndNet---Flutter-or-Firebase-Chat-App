import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/Components/MyInput.dart';
import 'package:flutter_application_1/Components/MySnackBar.dart';
import 'package:flutter_application_1/Pages/HomePage.dart';

class OtpPage extends StatefulWidget {
  final String otpKey;
  final String mobileNumber;
  final int? resendOtpToken;

  const OtpPage({
    super.key,
    required this.otpKey,
    required this.mobileNumber,
    required this.resendOtpToken,
  });

  @override
  State<OtpPage> createState() => _OtpPageState(
      mobileNumber: this.mobileNumber,
      resendOtpToken: resendOtpToken,
      otpKey: this.otpKey);
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String otpKey;
  String mobileNumber;
  int? resendOtpToken;

  _OtpPageState({
    required this.otpKey,
    required this.mobileNumber,
    required this.resendOtpToken,
  });

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = 30;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  final TextEditingController otpNumber = TextEditingController();
  String error = '';
  bool loading = false;
  void handelOtp() async {
    String otp = otpNumber.text;
    if (otp.isEmpty) {
      setState(() {
        error = "Please Enter Your OTP";
      });
    } else if (otp.length < 4) {
      setState(() {
        error = "Invalid OTP";
      });
    } else {
      setState(() {
        error = "";
        loading = true;
      });
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: otpKey, smsCode: otpNumber.text);
        await auth.signInWithCredential(credential);

        String? number = auth.currentUser!.phoneNumber;

        var GetCillection = firestore.collection("users").doc(number);
        var docRef = await GetCillection.get();
        if (!docRef.exists) {
          await GetCillection.set({
            "id": auth.currentUser!.uid,
            "mobile": number,
            "name": "User",
            "bio": "",
            "online":
                DateTime.now().add(const Duration(seconds: 30)).toString(),
            "pic":
                "https://firebasestorage.googleapis.com/v0/b/indnet-4fbb0.appspot.com/o/profile%2Fuser.png?alt=media&token=1775834c-5993-4595-baad-82cb416fd65d"
          });

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
        } else {
          await GetCillection.update({
            "online":
                DateTime.now().add(const Duration(seconds: 30)).toString(),
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
        }

        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
        print(resendOtpToken);
        setState(() {
          error = "You Enter Invalid OTP";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80.0),
                  Image.asset('assets/splash.png', height: 200.0),
                  const SizedBox(height: 60.0),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Mobile +91 $mobileNumber"),
                      )),
                  const SizedBox(height: 10.0),
                  MyInput(
                      controller: otpNumber,
                      onChanged: (val) {
                        setState(() {
                          if (error.isNotEmpty) {
                            error = "";
                          }
                        });
                      },
                      hintText: "Enter Your OTP",
                      icon: Icon(
                        Icons.keyboard_alt_rounded,
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
                              "Verify Your OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                      ontap: handelOtp,
                      color: loading
                          ? Color.fromARGB(255, 53, 53, 53)
                          : Color.fromARGB(255, 0, 0, 0),
                      desabl: loading),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not Resived Otp"),
                      _start == 30
                          ? TextButton(
                              onPressed: () async {
                                await auth.verifyPhoneNumber(
                                  phoneNumber: '+91$mobileNumber',
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {
                                    if (e.code == 'invalid-phone-number') {
                                      setState(() {
                                        error = "Invalid Mobile Number";
                                      });
                                    } else if (e.code ==
                                        'ERROR_TOO_MANY_REQUESTS') {
                                      setState(() {
                                        error =
                                            "Too many requests. Try again later.";
                                      });
                                    } else {
                                      setState(() {
                                        error = e.code;
                                      });
                                    }
                                  },
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        MySnackBar(
                                            title: "Resend OTP Successfully",
                                            onclick: null));

                                    setState(() {
                                      otpKey = verificationId;
                                      resendOtpToken = resendToken;
                                    });
                                  },
                                  forceResendingToken: resendOtpToken,
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );

                                startTimer();
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(color: Colors.black),
                              ))
                          : TextButton(
                              onPressed: null, child: Text("$_start sec"))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
