import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/Utils/text_use.dart';
import 'package:needful/pages/home.dart';
import 'package:needful/provider/token_provider.dart';
import 'package:needful/widgets/Button_for_pop_up.dart';
import 'package:needful/widgets/button_at_bottom.dart';
import 'package:needful/widgets/pop_up.dart';
import 'package:needful/widgets/title_bar.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final int itemid;
  final String username;
  final VoidCallback? onUpdateBuy;
  // final int? userIdOfUser;
  const ItemDetails({
    super.key,
    required this.itemid,
    required this.username,
    this.onUpdateBuy,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int? userIdFromToken;

  @override
  void initState() {
    super.initState();
    fetchItem();
  }

  Future<Map<String, dynamic>> fetchItem() async {
    
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.get(
      'http://10.0.2.2:5428/GetItemDetailsByItemId/${widget.itemid}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        userIdFromToken = userId;
      });
      return response.data;
    } else {
      throw Exception('Failed to load wishlists');
    }
    
  }
// /DeleteItemByItemId/:ItemID
  Future<void> deleteItem() async {
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.delete(
      'http://10.0.2.2:5428/DeleteItemByItemId/${widget.itemid}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      return null; 
    } else {
      throw Exception('Failed to deleteItem');
    }
  }

  // Future<void> _launchUrl(String url) async {
  //   // final Uri uri = Uri.parse(url);
  //   // Simulate a delay for launching the URL
  //   await Future.delayed(const Duration(seconds: 1));

  //   showDialog(
  //     context: context,
  //     builder: (context) => PopUp(
  //       title: 'Have you bought the wish?',
  //       buttons: [
  //         ButtonForPopUp(
  //             onPressed: () async {
  //               await _postGranter();
  //               Navigator.of(context).pop();
  //               if (widget.onUpdateBuy != null) { // Check if callback is provided
  //                 widget.onUpdateBuy!();
  //                 print(widget.onUpdateBuy);
  //               }
  //               Navigator.of(context).pop();
  //             },
  //             text: 'Yes'),
  //         ButtonForPopUp(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.of(context).pop();
  //               if (widget.onUpdateBuy != null) { // Check if callback is provided
  //                 widget.onUpdateBuy!(); // Call the callback
  //               }
  //             },
  //             text: 'No'),
  //       ],
  //     ),
  //   );
  // }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchItem(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final wishdata = snapshot.data;
          final itemName = wishdata?['itemname'] ?? 'Unknown Item';
          final description = wishdata?['description'] ?? 'Unknown description';
          final pics = wishdata?['item_pic'] ?? 'Unknown pics';
          final userId = (wishdata?['user_id']) ?? 0;
          final askbyUserId = wishdata?['asked_by_user_id'] ?? 0;
          final alreadyGave = wishdata?['already_gave'] ?? null;
          final offerType = wishdata?['offer_type'] ?? 'Unknown offerType';
          final username = widget.username;
          return Scaffold(
            backgroundColor: colorUse.backgroundColor,
            appBar: CustomAppBarNavigation(
              backgroundColor: colorUse.backgroundColor,
              title: itemName,
              backDestination: const Home(),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Image.network(
                      pics ??
                          'https://via.placeholder.com/350/FFFFFF/000000?text=Image+Not+Found', // Placeholder URL
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      errorBuilder: (context, error, stackTrace) {
                        // Optional: Handle image loading errors gracefully
                        return Image.network(
                          'https://via.placeholder.com/350/FFFFFF/000000?text=Image+Not+Found', // Fallback image
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.4,
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // RegularTextBold(
                          //   wishdata?.containsKey('price') == true
                          //       ? '\$${(wishdata?['price'] as num)}' ??
                          //           '\$0'
                          //       : '',
                          // ),
                          // const SizedBox(height: 10),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Propose by'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RegularText(
                                username), // Replace with actual data
                          ),
                          const SizedBox(height: 24),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Description'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RegularText(
                                description), // Replace with actual data
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    if (userId == userIdFromToken)
                      ButtonAtBottom(
                        onPressed: () async {
                         await deleteItem();
                         Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => Home()));
                          widget.onUpdateBuy;
                        },
                        text: 'Delete item',
                        color: colorUse.rejectButton,
                      ),

                    if (userId != userIdFromToken && offerType == 'Receive')
                      ButtonAtBottom(
                        onPressed: () {

                        },
                        text: 'Donate',
                        color: colorUse.activeButton,
                      ),

                    if (userId != userIdFromToken && offerType == 'Donate')
                      ButtonAtBottom(
                        onPressed: () {
                          
                        },
                        text: 'Ask for Receive',
                        color: colorUse.activeButton,
                      ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
