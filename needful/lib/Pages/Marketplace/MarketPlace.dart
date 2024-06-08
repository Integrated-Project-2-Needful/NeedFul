import 'package:flutter/material.dart';
import 'package:needful/Utils/color_use.dart';
import 'package:needful/widgets/MarketPlaceDonate.dart';
import 'package:needful/widgets/MarketPlaceReceive.dart';
// import 'package:sweet_favors/Utils/color_use.dart';
// import 'package:sweet_favors/pages/Friends/add_friend.dart';
// import 'package:sweet_favors/widgets/follower_content.dart';
// import 'package:sweet_favors/widgets/following_content.dart';

class MarketPlacePage extends StatefulWidget {
  const MarketPlacePage({Key? key}) : super(key: key);

  @override
  _FriendpageState createState() => _FriendpageState();
}

class _FriendpageState extends State<MarketPlacePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorUse.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "MarketPlace",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(240, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color(0xFF1B4D3F),
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 98, 98, 98),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 18.0),
        //     child: IconButton(
        //       icon: const Icon(Icons.person_add),
        //       color: const Color.fromARGB(240, 255, 255, 255),
        //       tooltip: 'Add friend',
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const AddFriend(),
        //             // this is not completed, it needs to check if the friend is mutual follow or not
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF4CB391),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Receive'),
                Tab(text: 'Donate'),
              ],
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              indicator: BoxDecoration(
                color: const Color.fromARGB(97, 27, 77, 63),
                borderRadius: BorderRadius.circular(4),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(169, 255, 255, 255),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MarketPlaceReceive(),
                MarketPlaceDonate(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
