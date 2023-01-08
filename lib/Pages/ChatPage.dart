import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/ChatInputBox.dart';
import 'package:flutter_application_1/res/ChatAppBar.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: ChatAppBar("Sourav Bapari", context),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              DateChip(
                date: new DateTime(2021, 5, 7),
                color: Color(0x558AD3D5),
              ),
              BubbleSpecialThree(
                text: "Thanks",
                color: Color(0xFFE8E8EE),
                tail: true,
                isSender: false,
                delivered: true,
                seen: true,
              )
            ],
          ),
        )),
        ChatInputBox()
      ]),
    );
  }
}
