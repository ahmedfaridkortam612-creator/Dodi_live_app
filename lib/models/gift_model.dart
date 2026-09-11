class Gift {
  final String id;
  final String name;
  final int price;
  final String icon;

  const Gift({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
  });
}

// قائمة الهدايا المتاحة في التطبيق (بأسعارها وأنواعها)
const List<Gift> availableGifts = [
  Gift(id: '1', name: 'وردة', price: 10, icon: '🌹'),
  Gift(id: '2', name: 'قصر', price: 500, icon: '🏰'),
  Gift(id: '3', name: 'سيارة فارهة', price: 1000, icon: '🏎️'),
  Gift(id: '4', name: 'أسد Dodi', price: 5000, icon: '🦁'),
];
