import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//! BU SAYFAYA ÖZEL BAZI TEMA AYARI OLDUĞUNDAN DOLAYI
//! BİRAZ DAHA KARMAŞIK ANA YAPISI :
//       appBar: _buildAppBar(appBarColor, textColor),
//       body: _buildAllContent(appBarColor, textColor),
//       bottomNavigationBar: _buildBottomAppBar(appBarColor),
//* BAZI KOD TEKRARLARININ SEBEBİ METOT YA DA WİDGET OLARAK AYIRINCA
//* HATA ALMAM VE ZAMANIMIN KISITI

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

  @override
  Widget build(BuildContext context) {
    final appBarColor = isDarkMode
        ? ColorItems.project_black
        : ColorItems.project_scaffold_color;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: _buildAppBar(appBarColor, textColor),
      body: _buildAllContent(appBarColor, textColor),
      bottomNavigationBar: _buildBottomAppBar(appBarColor),
    );
  }

  //! Metotlar

  BottomAppBar _buildBottomAppBar(Color appBarColor) {
    return BottomAppBar(
      color: appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copyContent,
            color:
                isDarkMode ? ColorItems.project_blue : ColorItems.project_gray,
          ),
          IconButton(
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleLike,
            color:
                isLiked ? ColorItems.project_orange : ColorItems.project_gray,
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
            color:
                isDarkMode ? ColorItems.project_blue : ColorItems.project_gray,
          ),
        ],
      ),
    );
  }

  Container _buildAllContent(Color appBarColor, Color textColor) {
    return Container(
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
                color: textColor,
              ),
            ),
            Text(
              widget.content,
              style: TextStyle(
                fontSize: WidgetSizes.mediumTextSize,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(Color appBarColor, Color textColor) {
    return AppBar(
      title: const Text(
        ProjectText.appName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: WidgetSizes.bigText,
        ),
      ),
      backgroundColor: appBarColor,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle:
          TextStyle(color: textColor, fontSize: WidgetSizes.largeTextSize),
    );
  }

  //! Metotlar

  Future<void> _toggleLike() async {
    if (isLiked) {
      showCustomSnackBar(context, 'İçerik Zaten Beğenildi');
    } else {
      await _authService.likeContent(widget.title, widget.content);
      // ignore: use_build_context_synchronously
      showCustomSnackBar(context, 'İçerik Beğenildi');
      setState(() => isLiked = true);
    }
  }

  Future<void> _copyContent() async {
    final textToCopy = '${widget.title}\n\n${widget.content}';
    await Clipboard.setData(ClipboardData(text: textToCopy));

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('İçerik kopyalandı!')),
    );
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
      //! System UI overlay style güncellemesi (İptal edildi)
      // SystemChrome.setSystemUIOverlayStyle(
      //   SystemUiOverlayStyle(
      //     statusBarColor: isDarkMode
      //         ? ColorItems.project_black
      //         : ColorItems.project_scaffold_color,
      //     statusBarIconBrightness:
      //         isDarkMode ? Brightness.light : Brightness.dark,
      //     systemNavigationBarColor: isDarkMode
      //         ? ColorItems.project_black
      //         : ColorItems.project_scaffold_color,
      //     systemNavigationBarIconBrightness:
      //         isDarkMode ? Brightness.light : Brightness.dark,
      //   ),
      // );
    });
  }
}
