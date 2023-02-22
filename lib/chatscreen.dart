import 'dart:async';
// import 'package:flutter_dotenv/flutter_dotenv.dark';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgpt_demo/threedonts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Chatmessage> _messages = [];
  
  // ChatGPT? chatGPT;//api
  late OpenAI? chatGPT;
  StreamSubscription? _subscription;

  bool _isTyping = false;
  final bool _isImageSearch = false;

  @override
  void initState(){
    
    super.initState();
    chatGPT = OpenAI.instance;

  }
  @override
  void dispose(){
    
    _subscription?.cancel();
    super.dispose();
  }
  //send message
  void _sendMessage(){

    if(_controller.text.isEmpty) return;

    Chatmessage message = Chatmessage(
      text: _controller.text, 
      sender: "user"
      );

      setState(() {
      _messages.insert(0,message);
      _isTyping = true;
    });
    _controller.clear();

    //create request
      final request = CompleteText(prompt:message.text,model: kTranslateModelV3);
    
    
    _subscription = chatGPT!.build(token: "PUT YOUR API KEY")
    .onCompleteStream(request:request)
    .listen((responce) {
      Vx.log(responce!.choices[0].text);
      Chatmessage botMMessage = Chatmessage(text:responce.choices[0].text, sender: "bot");

      setState(() {
        _isTyping = false;
        _messages.insert(0, botMMessage);
      });
    });
  }

  Widget _buildTextComposer(){
    return Row(
      children: [
         Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) =>  _sendMessage(),
          decoration: const InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        IconButton(
         icon: const Icon(Icons.send), 
         onPressed: () => _sendMessage(),
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
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: Vx.m8,
                itemCount: _messages.length,
                itemBuilder: (context, index){
                return _messages[index];
              }
            )),
            if(_isTyping) const ThreeDots(),
            const Divider(
              height: 1.0,
            ),
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
