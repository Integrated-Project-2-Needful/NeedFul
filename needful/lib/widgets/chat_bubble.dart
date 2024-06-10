import 'package:flutter/material.dart';
import 'package:needful/Components/integrate_model.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/Utils/text_use.dart';

class ChatBubble extends StatefulWidget {
  final int messageUserId;
  final int userId;
  final String messageUsername;


  const ChatBubble({
    super.key,
    required this.userId,
    required this.messageUserId,
    required this.messageUsername,
    });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  List<MessagePerUser> userMessage = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom initially and after each build
    fetchMessages().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); 
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent, // Use jumpTo instead of animateTo
      );
    }
  }

  Future<List<MessagePerUser>> fetchMessages() async {
  // Mock data (using your provided structure)
  final List<Map<String, dynamic>> mockData = [
    {
      'messageid':1,
      'userid': 1,
      'username': 'JohnDoe',
      'message': 'Hello, Girl!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg', 
    },
    {
      'messageid':2,
      'userid': 1,
      'username': 'JohnDoe',
      'message': 'I need the item now!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 2,
      'messageid': 3,
      'username': 'Scuff',
      'message': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 2,
      'messageid': 4,
      'username': 'Scuff',
      'message': 'I\m available tomorrow, are you?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 1,
      'messageid': 5,
      'username': 'JohnDoe',
      'message': 'Sure tomorrow what time?',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 2,
      'messageid': 6,
      'username': 'Scuff',
      'message': '12:00 AM at KMUTT',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 1,
      'messageid': 7,
      'username': 'JohnDoe',
      'message': 'Deal!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    
  ];

  // Simulate network delay (optional)
  // await Future.delayed(Duration(seconds: 1)); 

  // Parse the mock data
  List<MessagePerUser> userMessage = mockData.map((json) => MessagePerUser.fromJson(json)).toList();

  // (If you're using a StatefulWidget, you might have setState here)
  // setState(() { this.items = items; });

  return userMessage;
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        FutureBuilder<List<MessagePerUser>>(
            future: fetchMessages(),
            builder:(context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else if (snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                userMessage = snapshot.data!;
                if(userMessage.isEmpty){
                  return Center(
                    child: const Text('You don\'t have a message yet'),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                          controller: _scrollController,
                          // reverse: true,
                          shrinkWrap: true,
                          itemCount: userMessage.length,
                          itemBuilder: (context, index) {
                          final message = userMessage[index];
                          bool isMe = message.userid == widget.userId; // Check if the message is mine
                          bool showAvatar = index == 0 || userMessage[index - 1].userid != message.userid; 

                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container( 
                              // isMe ? (isLastConsecutive ? const Radius.circular(12) : Radius.zero) : const Radius.circular(12),
                              padding: isMe ? (!showAvatar ? const EdgeInsets.only(right: 50) : EdgeInsets.all(4.0) ) 
                                            : (!showAvatar ? const EdgeInsets.only(left: 50) : EdgeInsets.all(4.0) ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                // Reorder based on 'isMe'
                                children: [
                                 if (!isMe && showAvatar)
                                  CircleAvatar(backgroundImage: NetworkImage(message.img)),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Container(
                                      constraints: BoxConstraints(maxWidth: 180),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isMe ? colorUse.activeButton : Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(12),
                                          topRight: const Radius.circular(12),
                                          bottomRight: isMe ? (!showAvatar ? const Radius.circular(12) : Radius.zero) : const Radius.circular(12),
                                          bottomLeft: isMe ? const Radius.circular(12) : (!showAvatar ? const Radius.circular(12) : Radius.zero),
                                        ),
                                      ),
                                      child: RegularText(message.message),
                                    ),
                                  ),
                                  // RegularText(message.message),
                                  if (isMe && showAvatar) const SizedBox(width: 8), // Add space before avatar for my message
                                  if (isMe && showAvatar)
                                    CircleAvatar(backgroundImage: NetworkImage(message.img)),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                  );
                }
              }
            },
          )
    );
  }
}