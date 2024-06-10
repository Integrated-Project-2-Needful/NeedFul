import 'package:flutter/material.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/widgets/title_bar.dart';

class ChatRoom extends StatefulWidget {
  final int? messageUserId;
  final int? userId;

  const ChatRoom({super.key, this.messageUserId, this.userId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorUse.backgroundColor,
      appBar: CustomAppBarPop(
        backgroundColor: colorUse.primaryColor,
        title: 'Chat',
        centerTitle: true,
        ),
        // body: ,
    );
  }
}