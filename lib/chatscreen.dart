import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  Widget _buildTextComposer(){
    return Row(
      children: [
        const Expanded(
          child: TextField(
          decoration: InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        IconButton(
         icon: const Icon(Icons.send), 
         onPressed: () {  },
         )
      ],
    ).px16();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Chat with ChatGPT"),
      ),
    body: SafeArea(
      child: Column(
          children: [
            Flexible(child: Container(
              height: context.screenHeight,
            )),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor
              ),
              child:_buildTextComposer(),
            )
          ],
        ),
    ),
      );
  }
}