import 'package:flutter/material.dart';
import 'package:needful/Pages/Item/Item_details.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/components/integrate_model.dart' as components;
// import 'package:sweet_favors/Utils/color_use.dart';
// import 'package:sweet_favors/pages/Friends/friend_wishlist_followers.dart';
// import 'package:sweet_favors/components/follower_model.dart';
// import 'package:sweet_favors/provider/token_provider.dart';
// import 'package:sweet_favors/services/follower_service.dart';

class MarketPlaceDonate extends StatefulWidget {
  const MarketPlaceDonate({super.key});

  @override
  State<MarketPlaceDonate> createState() => _MarketPlaceDonateState();
}

class _MarketPlaceDonateState extends State<MarketPlaceDonate> {
  // late FollowerService _followerService;
  // late Future<List<Follower>> _followersFuture;
  List<components.Itemlist> items = [];

  @override
  void initState() {
    super.initState();
    // _followerService = FollowerService(Dio());
    // _followersFuture = _fetchFollowers();
  }

  // Future<List<Follower>> _fetchFollowers() async {
  //   final token = Provider.of<TokenProvider>(context, listen: false).token;
  //   final userId = Provider.of<TokenProvider>(context, listen: false).userId;
  //   final followers =
  //       await _followerService.fetchFollowersOfCurrentUser(token!, userId!);
  //   return followers;
  // }

  Future<List<components.Itemlist>> fetchItems() async {
    // Mock data
    final List<Map<String, dynamic>> mockData = [
      {
        'wishlist_id': 3,
        'user_id': 106,
        'itemname': 'PC',
        'price': 799,
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://www.digitaltrends.com/wp-content/uploads/2023/07/clx-hathor-review-11.jpg?fit=720%2C480&p=1',
        'already_bought': false,
        'username_of_granter': 'Alice',
        'username_of_wishlist': 'Test',
        'granted_by_user_id': 201,
      },
      {
        'wishlist_id': 4,
        'user_id': 104,
        'itemname': 'Peace',
        'price': 69,
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'already_bought': true,
        'username_of_granter': 'Test',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: FutureBuilder<List<components.Itemlist>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              childAspectRatio: 0.7,
              children: snapshot.data!.map((item) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetails(wishlist_id: item.itemlistId, username: '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 400,
                      padding: const EdgeInsets.all(8.0), // Add padding here
                      child: Stack(
                        children: [
                          // Outline for border ja
                                                    Positioned.fill( 
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22.5), 
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      colorUse.activeIconCircle,
                                      colorUse.activeIconCircle.withOpacity(0.7),
                                      colorUse.activeButton.withOpacity(0.9),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Image layer
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                item.itemPic!,
                                width: 200,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Text layer
                          SizedBox(
                            width: 200,
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.itemname,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
