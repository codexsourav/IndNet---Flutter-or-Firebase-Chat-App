import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/Components/ProfileUserInfoBox.dart';
import 'package:flutter_application_1/Components/UserProfileImageBox.dart';

import 'package:flutter_application_1/res/OnlyBackAppBar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OnlyBackAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: UserProfileImageBox(
                    context: context,
                    imgurl: "assets/user3.png",
                    name: "SouravBapari")),
            SizedBox(height: 80),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileUserInfoBox("Name", "Sourav Bapari"),
                  ProfileUserInfoBox("Bio", "If You Happy To Code"),
                  ProfileUserInfoBox("Phone Number", "+91 9382156026"),
                  SizedBox(height: 40.0),
                  // MyButton("Add To Friend", null, Colors.blue),
                  // SizedBox(height: 20.0),
                  // MyButton("Remove Friend", null, Colors.black),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
