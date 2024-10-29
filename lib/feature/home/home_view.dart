import 'package:edumix/product/services/category_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CategoryService _categoryService = CategoryService();

  List<String> _categories = [];
  bool _isLoading = true; // Yükleme durumu için değişken

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _categoryService.alphabeticalFetchCategories();
      setState(() {
        _categories = categories;
        _isLoading = false; // Yükleme tamamlandığında durumu güncelle
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() {
        _isLoading = false; // Hata durumunda da durumu güncelle
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategoriler')),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Yükleme göstergesi
          : _categories.isEmpty // Veri yoksa mesaj göster
              ? const Center(child: Text('Kategoriler bulunamadı.'))
              : ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _categories[index],
                        style: const TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        // Kategoriye tıklandığında yapılacak işlemler
                        // Yeni sayfaya yönlendirme yapılabilir
                      },
                    );
                  },
                ),
    );
  }
}
