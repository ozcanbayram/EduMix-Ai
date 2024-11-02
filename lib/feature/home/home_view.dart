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
      body: Padding(
        padding: const PagePadding.all(),
        child:
            _isLoading ? const CustomLoadingWidget() : _buildCategoriesView(),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
    );
  }

  //! Metodlar

  Widget _buildCategoriesView() {
    if (_categories.isEmpty) {
      return const Center(child: Text(ProjectText.categoriestNotFound));
    }

    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, index) =>
          _buildCategoryCard(context, _categories[index]),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    return Card(
      child: ListTile(
        trailing: const Icon(Icons.chevron_right_outlined),
        leading: const Icon(
          Icons.auto_awesome_outlined,
          color: ColorItems.project_orange,
        ),
        title: Padding(
          padding: CustomPaddings.verticalMedium,
          child: Text(
            category,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        subtitle: Text('$category ${ProjectText.subtitleDescription}'),
        onTap: () => navigateWithParameter(
          context,
          (param) => TitleGeneratorView(category: param),
          category,
        ),
      ),
    );
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      _categories = await _categoryService.alphabeticalFetchCategories();
    } catch (e) {
      // Hata durumunda belki bir kullanıcı mesajı eklenebilir
    } finally {
      setState(() => _isLoading = false);
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
