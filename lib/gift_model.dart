class GiftModel {
  final String id;
  final String name;
  final int cost;
  final String icon;
  final String animationType; // نوع الحركة (pop, fly, zoom, shake)
  final String soundEffect;   // تأثير الصوت

  const GiftModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.icon,
    required this.animationType,
    required this.soundEffect,
  });
}

// قايمة الهدايا الشاملة (تيك توك وميكو)
final List<GiftModel> allPlatformGifts = [
  // فئة الهدايا الرمزية (الاقتصادية)
  const GiftModel(id: '1', name: 'وردة', cost: 1, icon: '🌹', animationType: 'pop', soundEffect: 'rose_sound.mp3'),
  const GiftModel(id: '2', name: 'قلب', cost: 5, icon: '❤️', animationType: 'zoom', soundEffect: 'pop_sound.mp3'),
  const GiftModel(id: '3', name: 'قبعة الأمان', cost: 10, icon: '🧢', animationType: 'pop', soundEffect: 'click.mp3'),
  const GiftModel(id: '4', name: 'قهوة', cost: 20, icon: '☕', animationType: 'shake', soundEffect: 'sip.mp3'),
  const GiftModel(id: '5', name: 'آيس كريم', cost: 30, icon: '🍦', animationType: 'pop', soundEffect: 'pop_sound.mp3'),

  // فئة الهدايا المتوسطة والتفاعلية
  const GiftModel(id: '6', name: 'ميكروفون', cost: 99, icon: '🎤', animationType: 'zoom', soundEffect: 'mic_sound.mp3'),
  const GiftModel(id: '7', name: 'عقد لؤلؤ', cost: 199, icon: '📿', animationType: 'fly', soundEffect: 'bling.mp3'),
  const GiftModel(id: '8', name: 'قوس قزح', cost: 299, icon: '🌈', animationType: 'fly', soundEffect: 'magic.mp3'),
  const GiftModel(id: '9', name: 'خاتم الماس', cost: 520, icon: '💍', animationType: 'zoom', soundEffect: 'bling.mp3'),
  const GiftModel(id: '10', name: 'دبابة', cost: 699, icon: '🧸', animationType: 'shake', soundEffect: 'bear.mp3'),

  // فئة الهدايا الفخمة (تيك توك الشهيرة)
  const GiftModel(id: '11', name: 'صواريخ تيك توك', cost: 1000, icon: '🚀', animationType: 'fly', soundEffect: 'rocket.mp3'),
  const GiftModel(id: '12', name: 'سيارة رياضية', cost: 2999, icon: '🏎️', animationType: 'fly', soundEffect: 'car_engine.mp3'),
  const GiftModel(id: '13', name: 'قصر الأحلام', cost: 5000, icon: '🏰', animationType: 'zoom', soundEffect: 'castle.mp3'),
  const GiftModel(id: '14', name: 'اليونيكورن السحري', cost: 8888, icon: '🦄', animationType: 'fly', soundEffect: 'unicorn.mp3'),
  const GiftModel(id: '15', name: 'يخوت الملياردير', cost: 10000, icon: '🛥️', animationType: 'fly', soundEffect: 'boat.mp3'),

  // فئة هدايا الأساطير (الملوك - Top Tipping)
  const GiftModel(id: '16', name: 'أسد Dodi الملكي', cost: 29999, icon: '🦁', animationType: 'shake', soundEffect: 'lion_roar.mp3'),
  const GiftModel(id: '17', name: 'التنين الاسطوري', cost: 39999, icon: '🐉', animationType: 'fly', soundEffect: 'dragon.mp3'),
  const GiftModel(id: '18', name: 'كون الإمبراطور', cost: 100000, icon: '👑', animationType: 'zoom', soundEffect: 'emperor.mp3'),
];
