// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:needful/Components/profile_bar.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/widgets/card_widget.dart';
// import 'package:sweet_favors/Utils/text_use.dart';
// import 'package:sweet_favors/provider/token_provider.dart';
// import 'package:sweet_favors/widgets/card_widget.dart';
// // import 'package:sweet_favors/widgets/friends_msg_card.dart';
// import 'package:sweet_favors/widgets/profile_bar.dart';
import 'package:needful/components/integrate_model.dart' as components;


class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  String? username;
  String? email;
  String? img;
  String? firstname;
  String? lastname;
  String? fullname;
  int? userid;
  List<components.Itemlist> items = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchItems();
  }

  Future<void> fetchUserData() async {
    // final token = Provider.of<TokenProvider>(context, listen: false).token;
    // final userId = Provider.of<TokenProvider>(context, listen: false).userId;

    // Mock user data
    setState(() {
      username = 'JohnDoe';
      email = 'johndoe@example.com';
      img = 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg';
      firstname = 'John';
      lastname = 'Doe';
      fullname = '$firstname $lastname';
      userid = 1;
    });
  }

  Future<List<components.Itemlist>> fetchItems() async {
    // Mock data
    final List<Map<String, dynamic>> mockData = [
      {
        'wishlist_id': 1,
        'user_id': 101,
        'itemname': 'Smartphone',
        'price': 699,
        'link_url': 'https://example.com/smartphone',
        'item_pic': 'https://example.com/smartphone.jpg',
        'already_bought': false,
        'username_of_granter': 'Alice',
        'username_of_wishlist': 'Bob',
        'granted_by_user_id': 201,
      },
      {
        'wishlist_id': 2,
        'user_id': 102,
        'itemname': 'Laptop',
        'price': 999,
        'link_url': 'https://example.com/laptop',
        'item_pic': 'https://example.com/laptop.jpg',
        'already_bought': true,
        'username_of_granter': 'Charlie',
        'username_of_wishlist': 'Dave',
        'granted_by_user_id': 202,
      },
    ];

    // Simulate network delay
    // await Future.delayed(Duration(seconds: 2));

    // Parse the mock data
    List<components.Itemlist> items = mockData.map((json) => components.Itemlist.fromJson(json)).toList();

    setState(() {
      this.items = items;
    });

    return items;
  }

  void refreshItems() {
    setState(() {
      fetchItems();
    });
  }
// class FirstHomePage extends StatefulWidget {
//   const FirstHomePage({super.key});

//   @override
//   State<FirstHomePage> createState() => _FirstHomePageState();
// }

// class _FirstHomePageState extends State<FirstHomePage> {
  // final url = Endpoints.baseUrl;
  // List<components.Wishlist> wishlists = [];
  // String? username = 'Test User';
  // String? email = 'testuser@example.com';
  // String? img = 'https://via.placeholder.com/150'; // Example profile picture URL
  // String? firstname = 'Test';
  // String? lastname = 'User';
  // String? fullname = 'Test User';
  // int? userid = 1;
  // List<Item> items = [];
  
  
  // @override
  // void initState() {
  //   super.initState();
    // fetchWishlists();
    // fetchUserData();
  // }


  // void refreshItems() {
  //   setState(() {
  //     // Trigger rebuild by updating state
  //     fetchItems(); // Re-fetch items
  //   });
  // }
  // Future<List<components.Wishlist>> fetchItems() async {
  //   final token = Provider.of<TokenProvider>(context, listen: false).token;
  //   Dio dio = Dio();
  //   final response = await dio.get(
  //     'http://10.0.2.2:1432/GetWishlistsOfCurrentUser',
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     final parsedJson = response.data as List;
  //     items = parsedJson.map((json) => Item.fromJson(json)).toList();
  //     return items;
  //   } else {
  //     throw Exception('Failed to load items');
  //   }
  // }

  // void refreshWishlists() {
  //   setState(() {
  //     // Trigger rebuild by updating state
  //     fetchWishlists(); // Re-fetch wishlists
  //   });
  // }

  // Future<void> fetchUserData() async {
  //   final token = Provider.of<TokenProvider>(context, listen: false).token;
  //   final userId = Provider.of<TokenProvider>(context, listen: false).userId;
  //   Dio dio = Dio();
  //   final response = await dio.get(
  //     'http://10.0.2.2:1432/GetProfileOfCurrentUser/$userId',
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json', // Adjust content type as needed
  //       },
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     final parsedJson = response.data; // Directly get the parsed data
  //     setState(() {
  //       // Update the username and email variables with the parsed user data
  //       username = parsedJson['username'];
  //       email = parsedJson['email'];
  //       img = parsedJson['user_pic'];
  //       firstname = parsedJson['firstname'];
  //       lastname = parsedJson['lastname'];
  //       fullname = '$firstname $lastname';
  //       userid = userId;
  //     });
  //   } else {
  //     throw Exception('Failed to load user data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( // Use PreferredSize to customize AppBar height
        preferredSize: const Size.fromHeight(100), // Set your desired height
        child: AppBar(
          backgroundColor: colorUse.primaryColor,
          toolbarHeight: 40, // Height for content within AppBar
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft, // Position ProfileBar at bottom-left
            child: Padding(
              padding: const EdgeInsets.only(left:5, right:5, top:30, bottom: 10),
              child: ProfileBar(
                images: img ?? '',
                name: username ?? '',
                email: email ?? '',
                fullname: fullname ?? '',
              ),
            ),
          ),
        ),
      ),
      backgroundColor: colorUse.backgroundColor,
      body: Column(
          // Main column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   color: colorUse.primaryColor,
            //   height: 40.0,
            // ),
            // Profile Row
            // Container(
            //   color: colorUse.primaryColor,
            //   height: AppBar().preferredSize.height,
            //   width: 400,
            //   child: ProfileBar(
            //     images: img ?? '',
            //     name: username ?? '',
            //     email: email ?? '',
            //     fullname: fullname ?? '',
            //   ),
            // ),
            
            const SizedBox(height: 25.0), // Spacing between profile and card

            Expanded(
              child:Padding(
                padding: const EdgeInsets.all(20.0),
                child: 
               FutureBuilder<List<components.Itemlist>>(
                future: fetchItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    items = snapshot.data!;
                    if (items.isEmpty) {
                      return const Center(
                          child: Text(
                        'You don\'t have a wish yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ));
                    } else {
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final wishlist = items[index];
                          return CardWidget(
                            product: wishlist.itemname,
                            grantBy: wishlist.userNameOfGranter,
                            grantedByUserId: wishlist.grantedByUserId,
                            wishlistId: wishlist.itemlistId,
                            username:
                                username, // Access from the surrounding scope
                            userid: userid, // Access from the surrounding scope
                            alreadyBought: wishlist.alreadyBought,
                            // onUpdate: refreshWishlists,
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
      )],
        ),
      );
  }
}
