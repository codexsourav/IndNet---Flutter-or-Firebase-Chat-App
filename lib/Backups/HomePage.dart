import 'package:flutter/material.dart';

import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/Components/ProfileUserInfoBox.dart';
import 'package:flutter_application_1/Components/UserProfileImageBox.dart';
import 'package:flutter_application_1/Model/onlineTime.dart';
import 'package:flutter_application_1/Model/user_info.dart';
import 'package:flutter_application_1/Pages/LoginPage.dart';
import 'package:flutter_application_1/Pages/UpdateProfile.dart';
import 'package:flutter_application_1/res/OnlyBackAppBar.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var userInfo = UserInfo();
    return StreamBuilder(
      stream: userInfo.firestore
          .collection("users/")
          .doc(userInfo.auth.currentUser!.phoneNumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: OnlyBackAppbar(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserProfileImageBox(
                            context: context,
                            imgurl: snapshot.data!["pic"],
                            name: snapshot.data!["name"],
                            online: OnlineTime().getOnlineStatus(
                                snapshot.data!['online'].toString())),
                        const SizedBox(height: 80.0),
                        ProfileUserInfoBox("Name", snapshot.data!["name"]),
                        ProfileUserInfoBox(
                            "Bio",
                            snapshot.data!["bio"] != ""
                                ? snapshot.data!["bio"]
                                : "I AM Useing IndNet"),
                        ProfileUserInfoBox(
                            "Phone Number", snapshot.data!["mobile"]),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 50.0),
                        MyButton(
                          color: const Color.fromARGB(255, 52, 114, 165),
                          name: const Text(
                            "Update Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UpdateProfile(
                                  bio: snapshot.data!["bio"],
                                  name: snapshot.data!["name"]),
                            ));
                          },
                        ),
                        const SizedBox(height: 20.0),
                        MyButton(
                            name: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            ontap: () {
                              userInfo.auth.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (Route<dynamic> route) => false);
                            }),
                        const SizedBox(height: 20.0),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: OnlyBackAppbar(context),
            body: const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
          );
        }
      },
    );
  }
}
