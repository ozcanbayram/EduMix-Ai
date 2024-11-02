import 'package:edumix/core/constants/color_items.dart';
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
  String _currentTitle = '';
  String _fullContent = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateTitleAndContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
      ),
      body: _isLoading
          ? const CustomLoadingWidget()
          : Padding(
              padding: const PagePadding.all(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: _buildContentCard(),
                    ),
                  ),
                  _buildActionButtons(context),
                ],
              ),
            ),
    );
  }

  Widget _buildContentCard() {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorItems.project_light_blue,
              ColorItems.project_white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const PagePadding.all(),
          child: Column(
            children: [
              _buildTitleText(),
              _buildContentText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      _currentTitle.isNotEmpty
          ? _currentTitle
          : ProjectText.errorTitleGenerator,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: WidgetSizes.largeTextSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContentText() {
    return Text(
      _fullContent.isNotEmpty ? _fullContent : ProjectText.failCreateContent,
      style: const TextStyle(
        fontSize: WidgetSizes.mediumTextSize,
        fontWeight: FontWeight.w500,
      ),
      maxLines: WidgetSizes.maxLinesHigh,
      overflow: TextOverflow.ellipsis,
    );
  }

  Column _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ButtonLarge(
          onPressed: () {
            navigateTo(
              context,
              InformationView(
                title: _currentTitle,
                content: _fullContent,
                isLiked: false,
              ),
            );
          },
          buttonsText: ProjectText.readThisAbout,
        ),
        ButtonLarge(
          onPressed: _refreshTitleAndContent,
          buttonsText: ProjectText.refreshAbout,
        ),
      ],
    );
  }

  Future<void> _generateTitleAndContent() async {
    setState(() => _isLoading = true);

    try {
      final title = await titleGeneratorAi(widget.category);
      final content = await informationCreator(title ?? '');
      _currentTitle = title ?? '';
      _fullContent = content ?? '';
    } catch (e) {
      // Hata durumunda varsayılan değer ataması yapılır.
      _currentTitle = ProjectText.errorTitleGenerator;
      _fullContent = ProjectText.failCreateContent;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshTitleAndContent() async {
    await _generateTitleAndContent();
  }
}
