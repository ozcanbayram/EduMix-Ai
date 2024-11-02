import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/title_generator_view.dart/title_generator_view.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/services/category_service.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:edumix/product/widgets/main_app_bar.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';

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
      appBar: MainAppBar(onLogout: _signOut),
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
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 0,
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
    showCustomSnackBar(context, ProjectText.signedOut);
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
            onTap: () {
              navigateWithParameter(
                context,
                (param) => TitleGeneratorView(category: param),
                _categories[index],
              );
            },
          ),
        );
      },
    );
  }
}
