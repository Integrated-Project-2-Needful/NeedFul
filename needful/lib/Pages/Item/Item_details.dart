import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:needful/Utils/color_use.dart';
// import 'package:provider/provider.dart';
import 'package:needful/Utils/text_use.dart';
// import 'package:needful/provider/token_provider.dart';
import 'package:needful/pages/home.dart';
import 'package:needful/widgets/Button_for_pop_up.dart';
import 'package:needful/widgets/button_at_bottom.dart';
import 'package:needful/widgets/pop_up.dart';
import 'package:needful/widgets/title_bar.dart';

class ItemDetails extends StatefulWidget {
  final int wishlist_id;
  final String username;
  final VoidCallback? onUpdateBuy;
  // final int? userIdOfUser;
  const ItemDetails({
    super.key,
    required this.wishlist_id,
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
    fetchWishlists();
  }

  Future<Map<String, dynamic>> fetchWishlists() async {
    // Commented out for static data example
    /*
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.get(
      'http://10.0.2.2:1432/GetWishlistDetails/${widget.wishlist_id}',
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
    */

    // Static data for testing
    userIdFromToken = 1; // Example user ID from token
    return {
      'itemname': 'Test Item',
      'price': 20.0,
      'link_url': 'https://example.com',
      'item_pic': 'https://cdn-prod.medicalnewstoday.com/content/images/articles/324/324771/close-up-of-a-cup-of-tea.jpg',
      'user_id': 2, // Example user ID of the wish creator
      'already_bought': false,
      'granted_by_user_id': null,
    };
  }

  Future<Map<String, dynamic>> _postGranter() async {
    // Commented out for static data example
    /*
    final token = Provider.of<TokenProvider>(context, listen: false).token;
    final userId = Provider.of<TokenProvider>(context, listen: false).userId;
    Dio dio = Dio(); // Create a Dio instance
    final response = await dio.put(
      'http://10.0.2.2:1432/UpdateGrantForFriend/${widget.wishlist_id}/${userId}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to put _PostGranter');
    }
    */

    // Static data for testing
    return {'success': true};
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    // Simulate a delay for launching the URL
    await Future.delayed(const Duration(seconds: 1));

    showDialog(
      context: context,
      builder: (context) => PopUp(
        title: 'Have you bought the wish?',
        buttons: [
          ButtonForPopUp(
              onPressed: () async {
                await _postGranter();
                Navigator.of(context).pop();
                if (widget.onUpdateBuy != null) { // Check if callback is provided
                  widget.onUpdateBuy!();
                  print(widget.onUpdateBuy);
                }
                Navigator.of(context).pop();
              },
              text: 'Yes'),
          ButtonForPopUp(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                if (widget.onUpdateBuy != null) { // Check if callback is provided
                  widget.onUpdateBuy!(); // Call the callback
                }
              },
              text: 'No'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWishlists(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final wishdata = snapshot.data;
          final itemName = wishdata?['itemname'] ?? 'Unknown Item';
          final linkurl = wishdata?['link_url'] ?? 'Unknown link';
          final pics = wishdata?['item_pic'] ?? 'Unknown pics';
          final userId = (wishdata?['user_id']) ?? 0;
          final username = widget.username;
          final alreadyBought = (wishdata?['already_bought']);
          final grantBy = (wishdata?['granted_by_user_id']);
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
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegularTextBold(
                            wishdata?.containsKey('price') == true
                                ? '\$' +
                                        (wishdata?['price'] as num)!
                                            .toString() ??
                                    '\$0'
                                : '',
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Request by'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RegularText(
                                username), // Replace with actual data
                          ),
                          const SizedBox(height: 24),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: RegularTextBold('Link URL'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RegularText(
                                linkurl), // Replace with actual data
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (userId != userIdFromToken)
                      ButtonAtBottom(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return PopUp(
                                  title: 'Do you want to grant the wish?',
                                  buttons: [
                                    ButtonForPopUp(
                                        onPressed: () async {
                                          Navigator.of(dialogContext).pop();
                                          await _launchUrl(linkurl);
                                        },
                                        text: 'Yes'),
                                    ButtonForPopUp(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        text: 'No'),
                                  ],
                                );
                              });
                        },
                        text: 'GRANT WISH',
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
