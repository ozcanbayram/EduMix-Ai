import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/services/category_service.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:edumix/product/widgets/custom_text_field.dart';
import 'package:edumix/product/widgets/main_app_bar.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:edumix/product/widgets/search_view_widgets.dart';
import 'package:flutter/material.dart';

class CategorySearchPage extends StatefulWidget {
  const CategorySearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategorySearchPageState createState() => _CategorySearchPageState();
}

class _CategorySearchPageState extends State<CategorySearchPage> {
  final CategoryService _categoryService = CategoryService();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(onLogout: _signOut),
      body: _searchContent(),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
    );
  }

  //! metotlar

  Padding _searchContent() {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        children: [
          SearchTextField(onSearch: _onSearch),
          Expanded(
            child: _isLoading
                ? const SingleChildScrollView(child: LoadingIndicator())
                : ResultList(_searchResults),
          ),
        ],
      ),
    );
  }

  // Arama metodu
  Future<void> _onSearch(String query) async {
    _setLoading(true);

    final results =
        await _categoryService.searchCategories(query.toLowerCase());
    setState(() {
      _searchResults = _sortResults(results, query);
      _setLoading(false);
    });
  }

  List<Map<String, dynamic>> _sortResults(
    List<Map<String, dynamic>> results,
    String query,
  ) {
    results.sort((a, b) {
      final aName = a['name']?.toString().toLowerCase() ?? '';
      final bName = b['name']?.toString().toLowerCase() ?? '';
      if (aName == query && bName != query) return -1;
      if (aName != query && bName == query) return 1;
      return aName.compareTo(bName);
    });
    return results;
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    // ignore: use_build_context_synchronously
    navigateReplacementTo(context, const WelcomePage());
    // ignore: use_build_context_synchronously
    showCustomSnackBar(context, ProjectText.signedOut);
  }
}
