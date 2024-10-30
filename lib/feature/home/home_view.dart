import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/services/category_service.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CategoryService _categoryService = CategoryService();
  final AuthService _authService = AuthService();

  List<String> _categories = [];
  bool _isLoading = true;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userName = await _authService.getUserName();
    setState(() {
      _userName = userName ??
          'Misafir'; // Kullanıcı adı bulunamazsa "Misafir" olarak ayarla
    });
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

  Future<void> _signOut() async {
    await _authService.signOut();
    navigateReplacementTo(context, const WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const PagePadding.all(),
          child: ImageEnums.logo.toImage,
        ),
        title: const Text(ProjectText.appName),
        // Text(
        //   _userName != null ? 'Hoşgeldin, $_userName!' : 'Hoşgeldiniz',
        //   maxLines: 1,
        //   style: const TextStyle(
        //     fontSize: 22,
        //     color: ColorItems.project_black,
        //   ),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const PagePadding.all(),
              child: _isLoading
                  ? const CustomLoadingWidget()
                  : _categories.isEmpty
                      ? const Center(child: Text('Kategoriler bulunamadı.'))
                      : ListView.builder(
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: ColorItems.project_white,
                              child: ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                trailing:
                                    const Icon(Icons.chevron_right_outlined),
                                leading: const Icon(
                                  Icons.auto_awesome_outlined,
                                  color: ColorItems.project_orange,
                                ),
                                title: Text(
                                  _categories[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  '${_categories[index]} hakkında yapay zeka tarafından sunulan sınırsız bilgi için sadece tıkla.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorItems.project_gray,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
