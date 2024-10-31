import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/title_generator_view.dart/title_generator_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({required this.category, super.key});
  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.auto_awesome_outlined,
          color: ColorItems.project_orange,
        ),
        title: Text(category['name']?.toString() ?? 'Kategori İsmi'),
        subtitle: Text(
          '${category['name']?.toString() ?? ''} ${ProjectText.subtitleDescription}',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          navigateWithParameter(
            context,
            (param) => TitleGeneratorView(category: param),
            category['name'].toString(),
          );
        },
      ),
    );
  }
}

// arama sonuclari
class ResultList extends StatelessWidget {
  const ResultList(this.results, {super.key});
  final List<Map<String, dynamic>> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SearchIndicator();
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final category = results[index];
        return CategoryCard(category: category);
      },
    );
  }
}
