import 'package:flutter/material.dart';
import 'dart:convert';

// ==========================================
// GLOBAL STATE (Ödev İsteri: Basit State Yönetimi)
// ==========================================
final ValueNotifier<List<ThriftItem>> favoritesNotifier = ValueNotifier([]);

// ==========================================
// MOCK DATA
// ==========================================
const String mockItemsJson = '''
[
  {
    "id": "1",
    "title": "Çalışma Masası",
    "description": "ahmet.y@kampus.edu.tr",
    "price": 350.0,
    "originalPrice": 500.0,
    "condition": "Az Kullanılmış",
    "imageUrl": "https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?auto=format&fit=crop&w=600&q=80",
    "badge": "İndirim",
    "sellerName": "Ahmet Y.",
    "category": "Mobilya"
  },
  {
    "id": "2",
    "title": "Matematik Ders Kitabı",
    "description": "zeynep.k@kampus.edu.tr",
    "price": 150.0,
    "originalPrice": null,
    "condition": "Temiz",
    "imageUrl": "https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=600&q=80",
    "badge": "Yeni Gibi",
    "sellerName": "Zeynep K.",
    "category": "Kitap"
  },
  {
    "id": "3",
    "title": "Retro Kamera",
    "description": "burak.can@kampus.edu.tr",
    "price": 850.0,
    "originalPrice": 1200.0,
    "condition": "Yıpranmış",
    "imageUrl": "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=600&q=80",
    "badge": "Acil",
    "sellerName": "Burak Can",
    "category": "Elektronik"
  },
  {
    "id": "4",
    "title": "Mini Buzdolabı",
    "description": "elif.s@kampus.edu.tr",
    "price": 0.0,
    "originalPrice": 1500.0,
    "condition": "Temiz",
    "imageUrl": "https://images.unsplash.com/photo-1584269600519-112d071b4d16?auto=format&fit=crop&w=600&q=80",
    "badge": "Ücretsiz",
    "sellerName": "Elif S.",
    "category": "Elektronik"
  },
  {
    "id": "5",
    "title": "Akustik Gitar",
    "description": "ozan.m@kampus.edu.tr",
    "price": 1200.0,
    "originalPrice": 1800.0,
    "condition": "Az Kullanılmış",
    "imageUrl": "https://images.unsplash.com/photo-1510915361894-db8b60106cb1?auto=format&fit=crop&w=600&q=80",
    "badge": null,
    "sellerName": "Ozan M.",
    "category": "Hobi"
  },
  {
    "id": "6",
    "title": "Masa Lambası",
    "description": "ayse.t@kampus.edu.tr",
    "price": 120.0,
    "originalPrice": 200.0,
    "condition": "Yeni Gibi",
    "imageUrl": "https://images.unsplash.com/photo-1513506003901-1e6a229e9d15?auto=format&fit=crop&w=600&q=80",
    "badge": null,
    "sellerName": "Ayşe T.",
    "category": "Mobilya"
  }
]
''';

// ==========================================
// MODELS
// ==========================================
class ThriftItem {
  final String id;
  final String title;
  final String description; // Artık e-mail tutuyor
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

// ==========================================
// MAIN ENTRY POINT
// ==========================================
void main() {
  runApp(const CampusThriftApp());
}

class CampusThriftApp extends StatelessWidget {
  const CampusThriftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusThrift',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/items': (context) => const ItemListScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          return PageRouteBuilder(
            settings: settings,
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => const ItemDetailScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        }
        return null;
      },
    );
  }
}

// ==========================================
// SCREENS
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Color(0xFF8E24AA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value.clamp(0.0, 1.0),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'CampusThrift',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Öğrenciler arası güvenli\nve hızlı pazar yeri',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/items');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      elevation: 8,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'İlanları Görüntüle',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<ThriftItem> allItems = [];
  List<ThriftItem> filteredItems = [];
  String selectedCategory = "Tümü";
  final List<String> categories = ["Tümü", "Mobilya", "Kitap", "Elektronik", "Hobi"];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    final List<dynamic> jsonList = jsonDecode(mockItemsJson);
    setState(() {
      allItems = jsonList.map((json) => ThriftItem.fromJson(json)).toList();
      filteredItems = allItems;
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "Tümü") {
        filteredItems = allItems;
      } else {
        filteredItems = allItems.where((item) => item.category == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('İlanlar'),
        elevation: 0,
        actions: [
          ValueListenableBuilder<List<ThriftItem>>(
            valueListenable: favoritesNotifier,
            builder: (context, favItems, child) {
              return IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.favorite),
                    if (favItems.isNotEmpty)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${favItems.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, '/favorites'),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Colors.deepPurple,
                    backgroundColor: Colors.grey[200],
                    onSelected: (selected) {
                      if (selected) {
                        _filterByCategory(category);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'Bu kategoride ilan bulunamadı.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: filteredItems.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return ItemCard(item: filteredItems[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Route Arguments ile veri alma (Ödev İsteri)
    final item = ModalRoute.of(context)!.settings.arguments as ThriftItem;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            pinned: true,
            actions: [
              ValueListenableBuilder<List<ThriftItem>>(
                valueListenable: favoritesNotifier,
                builder: (context, favItems, child) {
                  return IconButton(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.favorite),
                        if (favItems.isNotEmpty)
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${favItems.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/favorites'),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'item_image_${item.id}',
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 80),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                  if (item.badge != null && item.badge!.isNotEmpty)
                    Positioned(
                      top: 100,
                      right: 16,
                      child: BadgeWidget(text: item.badge!),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (item.price == 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'ÜCRETSİZ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          else
                            Text(
                              '${item.price.toStringAsFixed(0)} ₺',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.deepPurple,
                              ),
                            ),
                          if (item.originalPrice != null && item.price != 0)
                            Text(
                              '${item.originalPrice!.toStringAsFixed(0)} ₺',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildMetaChip(Icons.check_circle_outline, item.condition, Colors.blue),
                      const SizedBox(width: 12),
                      _buildMetaChip(Icons.person_outline, item.sellerName, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'İletişim Maili',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[800],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                // Aynı ürünü bir kereden fazla eklemesin
                final currentFavs = favoritesNotifier.value;
                if (!currentFavs.any((favItem) => favItem.id == item.id)) {
                  favoritesNotifier.value = [...currentFavs, item];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.title} favorilere eklendi!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      action: SnackBarAction(
                        label: 'Favorilere Git',
                        onPressed: () {
                          Navigator.pushNamed(context, '/favorites');
                        },
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.title} zaten favorilerinizde!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.favorite),
              label: const Text('Favorilere Ekle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorilerim'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ValueListenableBuilder<List<ThriftItem>>(
        valueListenable: favoritesNotifier,
        builder: (context, favItems, child) {
          if (favItems.isEmpty) {
            return const Center(
              child: Text(
                'Favorileriniz şu an boş.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: favItems.length,
            itemBuilder: (context, index) {
              final item = favItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
                  ),
                  title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item.price == 0 ? 'Ücretsiz' : '${item.price.toStringAsFixed(0)} ₺'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      final currentList = List<ThriftItem>.from(favoritesNotifier.value);
                      currentList.removeAt(index);
                      favoritesNotifier.value = currentList;
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ==========================================
// WIDGETS
// ==========================================
class BadgeWidget extends StatelessWidget {
  final String text;

  const BadgeWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData? iconData;

    final lowerText = text.toLowerCase();
    if (lowerText == 'ücretsiz') {
      badgeColor = const Color(0xFF00C853);
      iconData = Icons.card_giftcard;
    } else if (lowerText == 'acil') {
      badgeColor = const Color(0xFFD50000);
      iconData = Icons.local_fire_department;
    } else if (lowerText == 'indirim') {
      badgeColor = const Color(0xFFFF6D00);
      iconData = Icons.local_offer;
    } else {
      badgeColor = Colors.blueGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null) ...[
            Icon(iconData, color: Colors.white, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ThriftItem item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black26,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Named Routes ve Arguments ile geçiş (Ödev İsteri)
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: item,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'item_image_${item.id}',
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    ),
                  ),
                  if (item.badge != null && item.badge!.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: BadgeWidget(text: item.badge!),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.condition,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (item.price == 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'ÜCRETSİZ',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                    )
                  else
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      children: [
                        Text(
                          '${item.price.toStringAsFixed(0)} ₺',
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        if (item.originalPrice != null)
                          Text(
                            '${item.originalPrice!.toStringAsFixed(0)} ₺',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
