import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //! Kategorileri karisik çekme
  Future<List<String>> fetchCategories() async {
    try {
      // 'Categories' koleksiyonundaki tüm belgeleri çekiyoruz
      final QuerySnapshot snapshot =
          await _firestore.collection('Categories').get();

      // Belgeleri listele ve kategori isimlerini al
      final categories =
          snapshot.docs.map((doc) => doc['name'] as String).toList();

      // print('Veriler geliyor: $categories');

      // Kategori isimlerini döndürüyoruz
      return categories;
    } catch (e) {
      // Hata durumunda hata mesajını yazdırıyoruz
      print(
        'Kategorileri çekerken hata oluştu: $e',
      );
      // Boş bir liste döndürüyoruz
      return [];
    }
  }

  //! Kategorileri alfabetik çekme
  Future<List<String>> alphabeticalFetchCategories() async {
    try {
      // 'Categories' koleksiyonundaki tüm belgeleri çekiyoruz
      final QuerySnapshot snapshot = await _firestore
          .collection('Categories')
          .orderBy('name')
          .get(); // 'name' alanına göre sıralama ekliyoruz

      // Belgeleri listele ve kategori isimlerini al
      final categories =
          snapshot.docs.map((doc) => doc['name'] as String).toList();

      // Verilerin başarıyla çekildiğini belirten bir mesaj
      print('Veriler GELİYOR: $categories');

      // Kategori isimlerini döndürüyoruz
      return categories;
    } catch (e) {
      // Hata durumunda hata mesajını yazdırıyoruz
      print(
        ' ???? ***** ???? **** ???? **** HATA BURADA ???? ***** ???? **** ???? ****  Kategorileri çekerken hata oluştu: $e',
      );
      // Boş bir liste döndürüyoruz
      return [];
    }
  }
}
