class ThriftItem {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? originalPrice;
  final String condition;
  final String imageUrl;
  final String? badge;
  final String sellerName;
  final String category;

  ThriftItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.condition,
    required this.imageUrl,
    this.badge,
    required this.sellerName,
    required this.category,
  });

  factory ThriftItem.fromJson(Map<String, dynamic> json) {
    return ThriftItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null ? (json['originalPrice'] as num).toDouble() : null,
      condition: json['condition'],
      imageUrl: json['imageUrl'],
      badge: json['badge'],
      sellerName: json['sellerName'],
      category: json['category'] ?? 'Diğer',
    );
  }
}
