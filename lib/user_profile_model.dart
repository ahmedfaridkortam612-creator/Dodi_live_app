class UserProfileModel {
  final String name;
  final String avatarUrl;
  final int wealthLevel; // مستوى الثراء والشحن
  final int charmLevel;  // مستوى الجاذبية (للمذيعين)
  final int diamonds;    // رصيد الألماس/الكوينز
  final bool isVip;

  const UserProfileModel({
    required this.name,
    required this.avatarUrl,
    required this.wealthLevel,
    required this.charmLevel,
    required this.diamonds,
    required this.isVip,
  });
}
