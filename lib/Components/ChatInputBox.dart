import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class ChatInputBox extends StatelessWidget {
  const ChatInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MessageBar(
        messageBarColor: Colors.white,
        onSend: (send) => print("Send"),
        actions: [
          InkWell(
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 24,
            ),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: InkWell(
              child: Icon(
                Icons.camera_alt,
                color: Colors.green,
                size: 24,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
