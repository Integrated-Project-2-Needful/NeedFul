import 'package:flutter/material.dart';
import 'package:needful/Pages/Item/Item_details.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/components/integrate_model.dart' as components;
import 'package:needful/widgets/card_widget.dart';
// import 'package:sweet_favors/Utils/color_use.dart';
// import 'package:sweet_favors/pages/Friends/friend_wishlist_followers.dart';
// import 'package:sweet_favors/components/follower_model.dart';
// import 'package:sweet_favors/provider/token_provider.dart';
// import 'package:sweet_favors/services/follower_service.dart';

class HomePageReceive extends StatefulWidget {
  const HomePageReceive({super.key});

  @override
  State<HomePageReceive> createState() => _HomePageReceiveState();
}

class _HomePageReceiveState extends State<HomePageReceive> {
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
        'wishlist_id': 1,
        'user_id': 101,
        'itemname': 'Tea',
        'price': 699,
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://cdn-prod.medicalnewstoday.com/content/images/articles/324/324771/close-up-of-a-cup-of-tea.jpg',
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
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://reviewed-com-res.cloudinary.com/image/fetch/s--SHZfNhYu--/b_white,c_fill,cs_srgb,f_auto,fl_progressive.strip_profile,g_xy_center,h_668,q_auto,w_1187,x_833,y_803/https://reviewed-production.s3.amazonaws.com/1588384493638/macbook-hero-ii.jpg',
        'already_bought': true,
        'username_of_granter': 'Charlie',
        'username_of_wishlist': 'Dave',
        'granted_by_user_id': 202,
      },
      {
        'wishlist_id': 2,
        'user_id': 102,
        'itemname': 'Laptop',
        'price': 999,
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://reviewed-com-res.cloudinary.com/image/fetch/s--SHZfNhYu--/b_white,c_fill,cs_srgb,f_auto,fl_progressive.strip_profile,g_xy_center,h_668,q_auto,w_1187,x_833,y_803/https://reviewed-production.s3.amazonaws.com/1588384493638/macbook-hero-ii.jpg',
        'already_bought': true,
        'username_of_granter': 'Charlie',
        'username_of_wishlist': 'Dave',
        'granted_by_user_id': 202,
      },
      {
        'wishlist_id': 2,
        'user_id': 102,
        'itemname': 'Laptop',
        'price': 999,
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://reviewed-com-res.cloudinary.com/image/fetch/s--SHZfNhYu--/b_white,c_fill,cs_srgb,f_auto,fl_progressive.strip_profile,g_xy_center,h_668,q_auto,w_1187,x_833,y_803/https://reviewed-production.s3.amazonaws.com/1588384493638/macbook-hero-ii.jpg',
        'already_bought': true,
        'username_of_granter': 'Charlie',
        'username_of_wishlist': 'Dave',
        'granted_by_user_id': 202,
      },
      {
        'wishlist_id': 2,
        'user_id': 102,
        'itemname': 'Laptop',
        'price': 999,
        'link_url': 'https://img.freepik.com/free-photo/zen-balancing-pebbles-misty-lake_53876-138198.jpg',
        'item_pic': 'https://reviewed-com-res.cloudinary.com/image/fetch/s--SHZfNhYu--/b_white,c_fill,cs_srgb,f_auto,fl_progressive.strip_profile,g_xy_center,h_668,q_auto,w_1187,x_833,y_803/https://reviewed-production.s3.amazonaws.com/1588384493638/macbook-hero-ii.jpg',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: FutureBuilder<List<components.Itemlist>>(
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
                          final itemlist = items[index];
                          return CardWidget(
                            product: itemlist.itemname,
                            grantBy: itemlist.userNameOfGranter,
                            grantedByUserId: itemlist.grantedByUserId,
                            wishlistId: itemlist.itemlistId,
                            username:itemlist.userNameOfGranter, // Access from the surrounding scope
                            userid: itemlist.userId, // Access from the surrounding scope
                            alreadyBought: itemlist.alreadyBought,
                            // onUpdate: refreshWishlists,
                          );
                        },
                      );
                    }
                  }
                },
              ),
    );
  }
}