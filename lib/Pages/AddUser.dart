import 'package:flutter/material.dart';

import 'package:flutter_application_1/Components/MyButton.dart';
import 'package:flutter_application_1/res/OnlyBackAppBar.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OnlyBackAppbar(context),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 80.0),
              Text("Add New Chat Friend",
                  style: TextStyle(fontFamily: "snow", fontSize: 25.0)),
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.call,
                        color: Color.fromARGB(255, 58, 58, 58),
                      ),
                      prefixText: "+91 ",
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: -8, bottom: 11, top: 11, right: 15),
                      hintText: "Mobile Number"),
                ),
              ),
              SizedBox(height: 25.0),
              MyButton(name: Text("Search Your Friend"), ontap: () {})
            ],
          ),
        )),
      ),
    );
  }
}
