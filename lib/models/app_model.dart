// نموذج بيانات الغرفة الصوتية أو المرئية
class RoomModel {
  final String id;
  final String title;
  final String host;
  final int members;
  final String category;
  final bool isLiveVideo;

  RoomModel({
    required this.id,
    required this.title,
    required this.host,
    required this.members,
    required this.category,
    this.isLiveVideo = false,
  });
}

// نموذج بيانات الهدايا داخل البثوث والغرف
class GiftModel {
  final String name;
  final String icon;
  final int price;

  GiftModel({
    required this.name, 
    required this.icon, 
    required this.price,
  });
}

// نموذج بيانات المستخدم الشخصي
class UserModel {
  final String name;
  final String id;
  final int coins;
  final int diamonds;
  final String avatar;

  UserModel({
    required this.name,
    required this.id,
    required this.coins,
    required this.diamonds,
    required this.avatar,
  });
}
