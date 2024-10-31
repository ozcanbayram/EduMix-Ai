import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/product/services/category_service.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CategorySearchPage extends StatefulWidget {
  const CategorySearchPage({super.key});

  @override
  _CategorySearchPageState createState() => _CategorySearchPageState();
}

class _CategorySearchPageState extends State<CategorySearchPage> {
  final CategoryService _categoryService = CategoryService();
  List<Map<String, dynamic>> _searchResults = [];
  String _query = '';
  bool _isLoading = false;

  Future<void> _onSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    // Küçük harfe dönüştürülmüş sorgu ile arama 
    final results =
        await _categoryService.searchCategories(query.toLowerCase());

    // Tam eşleşenleri önce getir ardından diğer eşleşenleri ekle
    results.sort((a, b) {
      final aName = a['name']?.toString().toLowerCase() ?? '';
      final bName = b['name']?.toString().toLowerCase() ?? '';

      // Tam eşleşenleri önce getir
      if (aName == query && bName != query) {
        return -1;
      } else if (aName != query && bName == query) {
        return 1;
      } else {
        // Diğer sonuçları alfabetik olarak sırala
        return aName.compareTo(bName);
      }
    });

    setState(() {
      _searchResults = results;
      _query = query;
      _isLoading = false;
    });
  }

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
            TextField(
              cursorColor: ColorItems.project_blue,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ColorItems.project_text_color),
              onChanged: _onSearch,
              decoration: const InputDecoration(
                labelText: ProjectText.searchText,
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child:
                          SingleChildScrollView(child: CustomLoadingWidget()),
                    )
                  : _searchResults.isEmpty
                      ? Center(
                          child: Lottie.network(
                            'https://lottie.host/c4bb20e8-5175-4d59-bd3e-9fc2c3ba6941/RoAOEbKWZh.json',
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final category = _searchResults[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.auto_awesome_outlined,
                                  color: ColorItems.project_orange,
                                ),
                                title: Text(
                                  category['name']?.toString() ??
                                      'Kategori İsmi',
                                ),
                                subtitle: Text(
                                  '${category['name']?.toString() ?? ''} ${ProjectText.subtitleDescription}',
                                ),
                                trailing: const Icon(Icons.chevron_right),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
    );
  }
}
