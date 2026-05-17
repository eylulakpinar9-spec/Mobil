# CampusThrift

## Kısa Açıklama
CampusThrift, üniversite öğrencilerinin kendi aralarında ikinci el eşyalarını güvenli bir şekilde alıp satabileceği "Mini Katalog Uygulaması" prototipidir. Bu proje, Flutter kullanılarak eğitim amaçlı geliştirilmiş olup; Widget ağacı yapısı, sayfa geçişleri, Named Route Arguments kullanımı, Asset yönetimi (JSON ve Görsel okuma) ve temel durum yönetimi (State Management - Favoriler Sistemi) özelliklerini içermektedir.

## Kullanılan Flutter Sürümü
- Flutter SDK (Projenin geliştirildiği SDK versiyonu >3.0.0)
- Dart SDK 

## Çalıştırma Adımları
Projeyi bilgisayarınızda çalıştırmak için aşağıdaki adımları izleyebilirsiniz:

1. Depoyu bilgisayarınıza klonlayın veya indirin:
   ```bash
   git clone <repository-url>
   ```
2. Proje dizinine gidin:
   ```bash
   cd CampusThrift
   ```
3. Gerekli Flutter paketlerini indirin:
   ```bash
   flutter pub get
   ```
4. Projeyi bağlı olan bir emülatör veya cihazda başlatın:
   ```bash
   flutter run
   ```

## Ödev Çıktısı Karşılanan Kriterler
- **Stateless ve Stateful Widget Kullanımı:** Başarıyla uygulandı.
- **Navigator ve Route Arguments:** Sayfalar arası geçişlerde Named Routes ve Route Arguments (`ModalRoute.of(context)!.settings.arguments`) yapısı kullanılarak veri taşıma işlemi gerçekleştirildi.
- **Liste ve GridView:** Ürünlerin listelenmesinde GridView kullanıldı.
- **JSON Simülasyonu:** `assets/data/products.json` dosyası üzerinden `rootBundle` ile veriler okunarak dinamik olarak modellere (`ThriftItem`) çevrildi.
- **Asset Yönetimi:** Gerekli JSON ve Görsel (Banner) dosyaları yerel `assets/` klasöründen okunmaktadır.
- **State Yönetimi (Favoriler):** `ValueNotifier` kullanılarak uygulamada ekstra paket kullanmadan global, basit bir "Favoriler" durumu oluşturuldu. Ürünler favorilere eklendiğinde ikon üzerindeki sayacın güncellenmesi başarıyla sağlandı.
