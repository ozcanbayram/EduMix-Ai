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
import 'package:google_nav_bar/google_nav_bar.dart';

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

  @override
  void initState() {
    super.initState();
    _loadCategories();
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
                      ? const Center(
                          child: Text(ProjectText.categoriestNotFound),
                        )
                      : CategoriesListView(categories: _categories),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: ColorItems.project_scaffold_color,
        child: Padding(
          padding: const PagePadding.all(),
          child: GNav(
            padding: const PagePadding.all(),
            gap: 10,
            backgroundColor: ColorItems.project_scaffold_color,
            color: ColorItems.project_text_color,
            rippleColor: ColorItems.project_orange,
            activeColor: ColorItems.project_white,
            tabBackgroundColor: ColorItems.project_blue,
            onTabChange: (value) {},
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                iconSize: 30,
                text: 'Anasayfa',
              ),
              GButton(
                icon: Icons.search,
                text: 'Kategori Ara',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.favorite_border_outlined,
                iconSize: 30,
                text: 'Beğeniler',
              ),
            ],
          ),
        ),
      ),
    );
  }

  //! ***** Metodlar ve Widgetlar *****

  //* Firebase metodları:
  Future<void> _loadCategories() async {
    try {
      final categories = await _categoryService.alphabeticalFetchCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      // print('Error loading categories: $e'); //for debugg
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    // ignore: use_build_context_synchronously
    navigateReplacementTo(context, const WelcomePage());
    // ignore: use_build_context_synchronously
    showCustomSnackBar(context, ProjectText.signedOuut);
  }
}

//* Kategori listesi:

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    required List<String> categories,
    super.key,
  }) : _categories = categories;

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            trailing: const Icon(Icons.chevron_right_outlined),
            leading: const Icon(
              Icons.auto_awesome_outlined,
              color: ColorItems.project_orange,
            ),
            title: Text(_categories[index]),
            subtitle: Text(
              '${_categories[index]} ${ProjectText.subtitleDescription}',
            ),
          ),
        );
      },
    );
  }
}
