import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Loadings/HomePageLoader.dart';
import 'package:flutter_application_1/Components/TitleBar.dart';
import 'package:flutter_application_1/Components/UserBox.dart';
import 'package:flutter_application_1/Model/user_info.dart';
import 'package:flutter_application_1/Pages/AddUser.dart';
import 'package:flutter_application_1/res/MyAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var userInfo = UserInfo();

    return FutureBuilder(
        future: userInfo.getUserData(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              body: MyAppBar(
                InfoData: snapshot.data,
                child: Column(children: [
                  TitleBar("Chats"),
                  UserBox(),
                ]),
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
          } else {
            return HomePageLoading();
          }
        }));
  }
}
