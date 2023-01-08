import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/UserPage.dart';

PreferredSizeWidget ChatAppBar(@required String name, var context) {
  Future<void> _openUserPage(BuildContext ctx) async {
    await Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => UserPage()));
  }

  return AppBar(
    elevation: 0.0,
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined,
            size: 18.0, color: Color.fromARGB(255, 12, 12, 12)),
        onPressed: () {
          Navigator.of(context).pop();
        }),
    title: Container(
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(right: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/user.png',
              height: 30.0,
              width: 30.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontFamily: "snow", fontSize: 10.0, color: Colors.black),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Online",
              style: TextStyle(fontSize: 8.0, color: Colors.green),
            ),
          ],
        )
      ]),
    ),
    actions: [
      Container(
        child: PopupMenuButton(
          elevation: 0.9,
          onSelected: (value) {
            switch (value) {
              case 0:
                Navigator.of(context).pop();
                break;
              case 1:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UserPage()));
                break;
              default:
                print("Invalid POtion");
            }
          },
          icon: Icon(
            Icons.more_vert_outlined,
            color: Colors.black,
            size: 20.0,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
                value: 0,
                child: Text(
                  "Go Back",
                  style: TextStyle(color: Colors.black),
                )),
            PopupMenuItem(
                value: 1,
                child: const Text(
                  "View Profile",
                  style: TextStyle(color: Colors.black),
                )),
            PopupMenuItem(
                value: 2,
                child: Text(
                  "Block User",
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      )
    ],
  );
}
