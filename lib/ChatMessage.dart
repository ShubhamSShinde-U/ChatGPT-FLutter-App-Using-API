import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class Chatmessage extends StatelessWidget {
  const Chatmessage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(sender)
        .text
        .subtitle1(context)
        .make()
        .box
        .color(sender=="user"?Vx.red200 : Vx.green200)
        .p16
        .rounded
        .alignCenter
        .makeCentered(),
      Expanded(
          child: text.trim().text.bodyText1(context).make().p8(),
        ),
      ],
    ).px8();
  }
}