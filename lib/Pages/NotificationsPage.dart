import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/MailBox.dart';
import 'package:flutter_application_1/Components/TitleBar.dart';
import 'package:flutter_application_1/Components/UserBox.dart';
import 'package:flutter_application_1/Pages/AddUser.dart';
import 'package:flutter_application_1/res/MyAppBar.dart';
import 'package:flutter_application_1/res/OnlyBackAppBar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: OnlyBackAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBar("Notifications"),
            MailBox(),
          ],
        ),
      ),
    );
  }
}
