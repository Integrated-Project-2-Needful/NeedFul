import 'package:flutter/material.dart';
import 'package:needful/Components/integrate_model.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/widgets/card_widget.dart';
import 'package:needful/widgets/text_form.dart';

class ChatLog extends StatefulWidget {
  const ChatLog({super.key});
  
  @override
  State<ChatLog> createState() => _ChatLogState();
}

class _ChatLogState extends State<ChatLog> {
  List<MessageLog> messages = [];
  int? userid;
  int? messageUserId;
  String? username;
  String? latestMessage;
  String? img;




  // Future<void> fetchUserData() async {
  //   // final token = Provider.of<TokenProvider>(context, listen: false).token;
  //   // final userId = Provider.of<TokenProvider>(context, listen: false).userId;

  //   // Mock user data
  //   setState(() {
  //     userid = 1;
  //     messageUserId = 2;
  //     username = 'JohnDoe';
  //     latestMessage = 'johndoe@example.com';
  //     img = 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg';

  //   });
    
  // }
  Future<List<MessageLog>> fetchMessages() async {
  // Mock data (using your provided structure)
  final List<Map<String, dynamic>> mockData = [
    {
      'userid': 1,
      'messageUserId': 2,
      'username': 'JohnDoe',
      'latestMessage': 'I need the item now!',
      'img': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
    },
    {
      'userid': 3,
      'messageUserId': 4,
      'username': 'Scuff',
      'latestMessage': 'Hello, John!',
      'img': 'https://i.ibb.co/3FDQHgV/362276652-1731342663961535-5299935558991469373-n.jpg', 
    },
    {
      'userid': 5,
      'messageUserId': 6,
      'username': 'BunnyGirl',
      'latestMessage': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 5,
      'messageUserId': 6,
      'username': 'BunnyGirl',
      'latestMessage': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 5,
      'messageUserId': 6,
      'username': 'BunnyGirl',
      'latestMessage': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 5,
      'messageUserId': 6,
      'username': 'BunnyGirl',
      'latestMessage': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 5,
      'messageUserId': 6,
      'username': 'BunnyGirl',
      'latestMessage': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    {
      'userid': 5,
      'messageUserId': 6,
      'username': 'BunnyGirl',
      'latestMessage': 'Meeting tomorrow?',
      'img': 'https://i.ibb.co/qxYnyxS/55555754-p0-master1200.jpg',
    },
    
  ];

  // Simulate network delay (optional)
  // await Future.delayed(Duration(seconds: 1)); 

  // Parse the mock data
  List<MessageLog> messages = mockData.map((json) => MessageLog.fromJson(json)).toList();

  // (If you're using a StatefulWidget, you might have setState here)
  // setState(() { this.items = items; });

  return messages;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorUse.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Chat Log",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1B4D3F),
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 171, 171, 171),
      ),
      body: Column(
        children: [
          Padding(
          padding: const EdgeInsets.all(12.0),
          child: 
            TextForm(
              label: 'Search',
              filled: false,
              maxLine: 1,
              // controller: ,
              ),
          ),
          Expanded(child: 
          FutureBuilder<List<MessageLog>>(
            future: fetchMessages(),
            builder:(context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else if (snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                messages = snapshot.data!;
                if(messages.isEmpty){
                  return Center(
                    child: const Text('You don\'t have a message yet'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final messagesList = messages[index];
                            return messageCard(
                              messageUserId: messagesList.messageUserId, 
                              username: messagesList.username, 
                              img: messagesList.img, 
                              latestMessage: messagesList.latestMessage,);
                          },
                    ),
                  );
                  
                }
              }
            },
          ))
        ],
      ),
    );
  }
}