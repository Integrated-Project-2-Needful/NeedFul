class Itemlist {
 final int itemlistId;         // Renamed from item_id for consistency
 final int userId;
 final String itemname;
 final String description;     // Added to match the JSON
 final String itemPic;
 final String offerType;       // Renamed for consistency, was offer_type
 final int? askedByUserId;      // Renamed for consistency, was asked_by_user_id
 final bool? alreadyGave;       // Renamed for consistency, was already_gave
 final String? username;
 final String? userPic;         // Added to match the JSON
 final String? usernameAskedByUserId; // Renamed for consistency

  Itemlist({
    required this.itemlistId,
    required this.userId,
    required this.itemname,
    required this.description, // Now required since it's in JSON
    required this.itemPic,
    required this.offerType,
    required this.askedByUserId,
    required this.alreadyGave,
    required this.username,
    required this.userPic, 
    required this.usernameAskedByUserId,
  });

  factory Itemlist.fromJson(Map<String, dynamic> json) {
    return Itemlist(
      itemlistId: json['item_id'],
      userId: json['user_id'],
      itemname: json['itemname'],
      description: json['description'], 
      itemPic: json['item_pic'],
      offerType: json['offer_type'],
      askedByUserId: json['asked_by_user_id'],
      alreadyGave: json['already_gave'],
      username: json['username'],
      userPic: json['user_pic'],
      usernameAskedByUserId: json['username_asked_by_user_id'],
    );
  }
}


class WishlistItem {
  final int id;
  final String product;
  final String grantBy;
  final int price;
  final String linkUrl;
  final String itemPic;
  // ... other properties

  WishlistItem({
    required this.id,
    required this.product,
    required this.grantBy,
    required this.price,
    required this.linkUrl,
    required this.itemPic,
  });
}

class WishItem {
  final int wishlistId;
  final int userId;
  final String itemname;
  final int price;
  final String linkurl;
  final String itemPic;
  final bool? alreadyBought;
  final int? grantedByUserId;
  final String usernameOfWishlist;
  final String? picOfWishlistUser;

  WishItem(
      {required this.wishlistId,
      required this.userId,
      required this.itemname,
      required this.price,
      required this.linkurl,
      required this.itemPic,
      this.alreadyBought,
      this.grantedByUserId,
      required this.usernameOfWishlist,
      this.picOfWishlistUser});

  factory WishItem.fromJson(Map<String, dynamic> json) {
    return WishItem(
      wishlistId: json['wishlist_id'],
      userId: json['user_id'],
      itemname: json['itemname'],
      price: json['price'],
      linkurl: json['link_url'],
      itemPic: json['item_pic'],
      alreadyBought: json['already_bought'],
      grantedByUserId: json['granted_by_user_id'],
      usernameOfWishlist: json['username_of_wishlist'],
      picOfWishlistUser: json['user_pic_of_wishlist'],
    );
  }
}


class MessageLog {
  final int userid;
  final int messageUserId;
  final String username;
  final String latestMessage;
  final String img;

  MessageLog({
    required this.userid,
    required this.messageUserId,
    required this.username,
    required this.latestMessage,
    required this.img,
  });

  factory MessageLog.fromJson(Map<String, dynamic> json) {
    return MessageLog(
      userid: json['userid'],
      messageUserId: json['messageUserId'],
      username: json['username'],
      latestMessage: json['latestMessage'],
      img: json['img'],
    );
  }
}

class MessagePerUser {
  final int messageid;
  final int userid;
  final String img;
  final String username;
  final String message;

  MessagePerUser({
    required this.messageid,
    required this.userid,
    required this.img,
    required this.username,
    required this.message,
  });

  factory MessagePerUser.fromJson(Map<String, dynamic> json) {
    return MessagePerUser(
      messageid: json['messageid'],
      userid: json['userid'],
      username: json['username'],
      message: json['message'],
      img: json['img'],
    );
  }
}