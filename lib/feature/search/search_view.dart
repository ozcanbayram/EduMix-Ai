import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/product/services/category_service.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:edumix/product/widgets/custom_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
        leading: Padding(
          padding: const PagePadding.all(),
          child: ImageEnums.logo.toImage,
        ),
      ),
      body: Padding(
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
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
    );
  }

  //! Metodlar :

  //arama metodu
  Future<void> _onSearch(String query) async {
    setState(() => _isLoading = true);

    final results =
        await _categoryService.searchCategories(query.toLowerCase());

    setState(() {
      _searchResults = _sortResults(results, query);
      _isLoading = false;
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
}
