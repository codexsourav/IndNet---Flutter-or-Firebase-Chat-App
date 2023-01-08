import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/ChatPage.dart';

class UserBox extends StatelessWidget {
  const UserBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromARGB(255, 231, 231, 231),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: Color.fromARGB(31, 129, 129, 129),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/user.png',
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sourav Bapari",
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      SizedBox(height: 5.0),
                      Text("How Are You?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 59, 59, 59),
                              fontSize: 10.0)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12.0),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage()));
                      },
                      icon: Icon(
                        Icons.message,
                        color: Color.fromARGB(255, 48, 48, 48),
                        size: 20.0,
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
