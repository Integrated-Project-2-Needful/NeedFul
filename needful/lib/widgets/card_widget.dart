// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:needful/Pages/Chats/ChatRoom.dart';
import 'package:needful/Pages/Item/Item_details.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/Utils/text_use.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_favors/pages/Wish/wish_details.dart';
// import 'package:sweet_favors/provider/token_provider.dart';


class CardWidget extends StatelessWidget {
  final String product;
  final String? grantBy;
  final int wishlistId;
  final String? username;
  final int? userid;
  final bool? alreadyBought;
  final int? grantedByUserId;
  final VoidCallback? onUpdate;
  final VoidCallback? onUpdateBuy;

  const CardWidget({
    super.key,
    required this.product,
    this.grantBy,
    required this.wishlistId,
    this.username,
    this.userid,
    this.alreadyBought,
    this.grantedByUserId,
    this.onUpdate,
    this.onUpdateBuy,
  });

  @override
  Widget build(BuildContext context) {
    // Future<Map<String, dynamic>> _RecieverGotIt() async {
    //   final token = Provider.of<TokenProvider>(context, listen: false).token;
    //   final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    //   Dio dio = Dio(); // Create a Dio instance
    //   final response = await dio.put(
    //     'http://10.0.2.2:1432/UpdateReceiverGotIt/$wishlistId/$grantedByUserId',
    //     options: Options(
    //       headers: {
    //         'Authorization': 'Bearer $token',
    //         'Content-Type': 'application/json', // Adjust content type as needed
    //       },
    //     ),
    //   );

    //   if (response.statusCode == 200) {
    //     return response.data;
    //   } else {
    //     throw Exception('Failed to put _RecieverGotIt');
    //   }
    // }

    // Future<Map<String, dynamic>> _RecieverDidntGetit() async {
    //   // final token = Provider.of<TokenProvider>(context, listen: false).token;
    //   // final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    //   Dio dio = Dio(); // Create a Dio instance
    //   final response = await dio.put(
    //     'http://10.0.2.2:1432/UpdateReceiverDidntGetIt/$wishlistId/$grantedByUserId',
    //     options: Options(
    //       headers: {
    //         'Authorization': 'Bearer $token',
    //         'Content-Type': 'application/json', // Adjust content type as needed
    //       },
    //     ),
    //   );

    //   if (response.statusCode == 200) {
    //     return response.data;
    //   } else {
    //     throw Exception('Failed to put _RecieverDidntGetit');
    //   }
    // }

    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: InkWell(
          onTap: () {
            if (grantBy != null && alreadyBought == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetails(
                    wishlist_id: wishlistId,
                    username: username ?? 'null',
                    onUpdateBuy: onUpdateBuy,
                  ),
                ),
              );
            } else if (grantBy != null && alreadyBought != true) {
              // showDialog(
              //     context: context,
              //     builder: (BuildContext dialogContext) {
              //       return PopUp(
              //         title: 'Did you recieved the wish?',
              //         buttons: [
              //           ButtonForPopUp(
              //               onPressed: () async {
              //                 Navigator.of(dialogContext).pop();
              //                 // await _RecieverGotIt();
              //                 onUpdate!();
              //               },
              //               text: 'Yes'),
              //           ButtonForPopUp(
              //               onPressed: () async {
              //                 Navigator.of(dialogContext).pop();
              //                 // await _RecieverDidntGetit();
              //                 onUpdate!();
              //               },
              //               text: 'No'),
              //         ],
              //       );
              //     });
            } else if (grantBy == null && alreadyBought == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetails(
                    wishlist_id: wishlistId,
                    username: username ?? 'null',
                    onUpdateBuy: onUpdateBuy,
                  ),
                ),
              );
            }
          },
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: grantBy != null && alreadyBought == true
                ? colorUse.activeButton // Green (granted and bought)
                : (grantBy != null || alreadyBought == true)
                    ? const Color(0xFFFCDDA2)
                    : const Color.fromARGB(198, 242, 215, 255),
            elevation: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10.0),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      product,
                      style: TextStyles.cardTitleStyle().merge(TextStyle(
                          color: grantBy != null && alreadyBought == true
                              ? const Color.fromARGB(224, 255, 255, 255)
                              : const Color.fromARGB(184, 0, 0, 0))),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String product;
  final Widget? destination;
  final IconData icon;
  const ProfileCard(
      {super.key, required this.product, this.destination, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination!,
                // builder: (context) => WishDetails(product: product, grantBy: grantBy),
              ),
            );
          },
          child: Card(
            // margin: EdgeInsets.only(bottom: 25),
            color: colorUse.secondaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(icon),
                  title: RegularText(product),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class messageCard extends StatelessWidget {
  final int? messageUserId;
  final String? username;
  final String? latestMessage;
  final String? img;

  const messageCard(
      {super.key,required this.messageUserId ,required this.username, this.latestMessage, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoom()),
          );
        },
        child: Card(
          color: colorUse.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                // Avatar (Using CachedNetworkImage for error handling)
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    img?? '',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Username
                      Text(
                        username?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Latest Message
                      Text(
                        latestMessage ?? '', 
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ], // Removed the SizedBox and Text for the timestamp
            ),
          ),
        ),
      ),
    );
  }
}