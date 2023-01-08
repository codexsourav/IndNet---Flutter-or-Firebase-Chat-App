import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/FriendBox.dart';
import 'package:flutter_application_1/Components/TitleBar.dart';
import 'package:flutter_application_1/Components/UserBox.dart';
import 'package:flutter_application_1/Pages/AddUser.dart';
import 'package:flutter_application_1/res/OnlyBackAppBar.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: OnlyBackAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBar('My Friends'),
            FriendBox(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            elevation: 0,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddUser(),
              ));
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
