import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InformationView extends StatefulWidget {
  const InformationView({
    required this.title,
    required this.content,
    required this.isLiked,
    super.key,
  });

  final String title;
  final String content;
  final bool isLiked;

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  late bool isLiked;
  bool isDarkMode = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  Future<void> _toggleLike() async {
    if (isLiked) {
      showCustomSnackBar(context, 'İçerik Zaten Beğenildi');
    } else {
      await _authService.likeContent(widget.title, widget.content);
      showCustomSnackBar(context, 'İçerik Beğenildi');
      setState(() => isLiked = true);
    }
  }

  Future<void> _copyContent() async {
    final textToCopy = '${widget.title}\n\n${widget.content}';
    await Clipboard.setData(ClipboardData(text: textToCopy));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('İçerik kopyalandı!')),
    );
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
      // System UI overlay style güncellemesi
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: isDarkMode
              ? ColorItems.project_black
              : ColorItems.project_scaffold_color,
          statusBarIconBrightness:
              isDarkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: isDarkMode
              ? ColorItems.project_black
              : ColorItems.project_scaffold_color,
          systemNavigationBarIconBrightness:
              isDarkMode ? Brightness.light : Brightness.dark,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = isDarkMode
        ? ColorItems.project_black
        : ColorItems.project_scaffold_color;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle:
            TextStyle(color: textColor, fontSize: WidgetSizes.largeTextSize),
      ),
      body: Container(
        color: appBarColor,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: WidgetSizes.largeTextSize,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              const SizedBox(height: 10),
              Text(
                widget.content,
                style: TextStyle(
                    fontSize: WidgetSizes.mediumTextSize, color: textColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: appBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: _copyContent,
              color: isDarkMode
                  ? ColorItems.project_blue
                  : ColorItems.project_gray,
            ),
            IconButton(
              icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
              onPressed: _toggleLike,
              color: isLiked ? Colors.red : null,
            ),
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
              color: isDarkMode
                  ? ColorItems.project_blue
                  : ColorItems.project_gray,
            ),
          ],
        ),
      ),
    );
  }
}
