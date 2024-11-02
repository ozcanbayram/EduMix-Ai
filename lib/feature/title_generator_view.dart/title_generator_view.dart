import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/feature/information_page.dart/information_page_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/ai_service.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:edumix/product/widgets/custom_loading_vidget.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class TitleGeneratorView extends StatefulWidget {
  const TitleGeneratorView({required this.category, super.key});
  final String category;

  @override
  State<TitleGeneratorView> createState() => _TitleGeneratorViewState();
}

class _TitleGeneratorViewState extends State<TitleGeneratorView> {
  late String _currentTitle;
  late String _fullContent;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateTitleAndContent();
  }

  Future<void> _generateTitleAndContent() async {
    setState(() => _isLoading = true);

    final title = await titleGeneratorAi(widget.category);
    final content = await informationCreator(title ?? '');

    setState(() {
      _currentTitle = title ?? 'Başlık Üretilirken Hata Oluştu';
      _fullContent = content ?? 'İçerik üretilemedi';
      _isLoading = false;
    });
  }

  Future<void> _refreshTitleAndContent() async {
    await _generateTitleAndContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
      ),
      body: _isLoading
          ? const Center(child: CustomLoadingWidget())
          : Padding(
              padding: const PagePadding.all(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: Card(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 152, 211, 247),
                                Colors.white,
                              ], // Renk geçişleri
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const PagePadding.all(),
                            child: Column(
                              children: [
                                Text(
                                  _currentTitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: WidgetSizes.largeTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _fullContent,
                                  style: const TextStyle(
                                    fontSize: WidgetSizes.mediumTextSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Butonlar
                  Column(
                    children: [
                      ButtonLarge(
                        onPressed: () {
                          navigateTo(
                            context,
                            InformationView(
                              title: _currentTitle,
                              content: _fullContent,
                              isLiked: false, // Beğenildi olarak ayarlanıyor
                            ),
                          );
                        },
                        buttonsText: ProjectText.readThisAbout,
                      ),
                      ButtonLarge(
                        onPressed: _refreshTitleAndContent,
                        buttonsText: 'Başka Konu Öner',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
