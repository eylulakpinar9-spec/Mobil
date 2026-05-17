import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/thrift_item.dart';
import '../widgets/item_card.dart';
import '../main.dart'; // For favoritesNotifier

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

  // Asset Yönetimi: JSON dosyasını rootBundle ile okuma (Ödev İsteri)
  Future<void> _loadItems() async {
    try {
      final String response = await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> jsonList = jsonDecode(response);
      setState(() {
        allItems = jsonList.map((json) => ThriftItem.fromJson(json)).toList();
        filteredItems = allItems;
      });
    } catch (e) {
      debugPrint("Veri yüklenirken hata oluştu: $e");
    }
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
                    child: CircularProgressIndicator(),
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
