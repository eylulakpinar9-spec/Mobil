const String mockItemsJson = '''
[
  {
    "id": "1",
    "title": "Çalışma Masası",
    "description": "IKEA marka beyaz çalışma masası. Mezun olduğum için satıyorum, ufak tefek çizikleri var ama oldukça sağlam. Yeni alıcıya şimdiden hayırlı olsun.",
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
    "description": "Calculus 101 dersi için temiz kullanılmış kitap. Üzerinde sadece kurşun kalemle alınmış hafif notlar var. Kitapçılarda sıfırı çok pahalı.",
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
    "description": "Çalışır durumda vintage analog fotoğraf makinesi. Lensi temiz ama gövdede kozmetik aşınmalar var. Koleksiyoncular veya hevesliler için kaçırılmayacak fırsat.",
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
    "description": "Öğrenci evleri için ideal boyutta soğutucu. Ev arkadaşım taşındığı için boşa çıktı. Gayet iyi çalışıyor. Taşınacağım için ücretsiz veriyorum.",
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
    "description": "Yamaha marka, çok az kullanılmış. Telleri yeni değişti. Kılıfı ile birlikte verilecektir, seste hiçbir bozulma yok.",
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
    "description": "Led ışıklı, ayarlanabilir boyunlu şık çalışma lambası. Geceleri vizelere hazırlanmak için birebir.",
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
