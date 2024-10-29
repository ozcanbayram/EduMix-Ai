import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/services/category_service.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CategoryService _categoryService = CategoryService();
  List<String> _categories = [];
  bool _isLoading = true;

  final AuthService _authService = AuthService(); // AuthService örneği

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
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading categories: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(width: 80, height: 40, child: ImageEnums.logo.toImage),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: _isLoading
            ? const LinearProgressIndicator() // Yükleme göstergesi
            : _categories.isEmpty
                ? const Center(child: Text('Kategoriler bulunamadı.'))
                : ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color.fromARGB(255, 234, 242, 255),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          // leading: const Icon(
                          //   Icons.menu_book_outlined,
                          //   // color: context.general.randomColor,
                          //   color: ColorItems.project_blue,
                          // ),

                          trailing: const Icon(Icons.chevron_right_outlined),
                          subtitle: Text(
                            '${_categories[index]} hakkında sınırsız bilgi için sadece tıkla.',
                          ),
                          title: Text(
                            _categories[index], // Kategori adını gösterir
                            style: const TextStyle(
                              fontSize: 18, // Yazı boyutunu ayarlamak için
                              fontWeight: FontWeight.bold, // Yazı kalınlığı
                              color: Colors.black, // Yazı rengi
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Future<void> _signOut() async {
    await _authService.signOut(); // Çıkış işlemi

    // Çıkış sonrası giriş sayfasına yönlendirme
    navigateReplacementTo(context, const WelcomePage());
  }
}




/*
Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      elevation: 4, // Kartın gölgesini ayarlamak için
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Kart köşelerini yuvarlatmak için
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          16,
                        ), // Kart içindeki boşluğu ayarlamak için
                        child: Text(
                          _categories[index], // Kategori adını gösterir
                          style: const TextStyle(
                            fontSize: 18, // Yazı boyutunu ayarlamak için
                            fontWeight: FontWeight.bold, // Yazı kalınlığı
                            color: Colors.black, // Yazı rengi
                          ),
                        ),
                      ),
                    );

*/