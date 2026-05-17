import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/item_list_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/item_detail_screen.dart';
import 'models/thrift_item.dart';

// Basit State Yönetimi için Global Değişken (Ödev simülasyonu için)
final ValueNotifier<List<ThriftItem>> favoritesNotifier = ValueNotifier([]);

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
          // Route Arguments Kullanımı (Ödev İsteri)
          return PageRouteBuilder(
            settings: settings, // Arguments'ı iletiyoruz
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
