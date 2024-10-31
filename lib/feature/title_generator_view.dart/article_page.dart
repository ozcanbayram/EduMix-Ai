// article_page.dart
import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Google Gemini paketini ekleyin

class ArticlePage extends StatefulWidget {
  const ArticlePage({required this.title, super.key});
  final String title;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late String _articleContent; // API'den gelecek içerik
  bool _isLoading = true; // Yükleme durumu

  @override
  void initState() {
    super.initState();
    _fetchArticleContent(); // İçeriği yüklemek için çağırıyoruz
  }

  Future<void> _fetchArticleContent() async {
    final content = await informationCreator(
      widget.title,
    ); // Bilgi oluşturma metodunu çağır
    setState(() {
      _articleContent =
          content ?? 'İçerik oluşturulamadı'; // Gelen içeriği güncelle
      _isLoading = false; // Yükleme durumu güncelleniyor
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              ) // Yükleme göstergesi
            : SingleChildScrollView(
                child: Text(
                  _articleContent,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorItems.project_text_color),
                ),
              ),
      ),
    );
  }

  // Bilgi üreten metot
  Future<String?> informationCreator(String title) async {
    final apiKey = dotenv.env['GOOGLE_GEMINI_API_KEY'];
    if (apiKey == null) {
      print(r'$GOOGLE_GEMINI_API_KEY ortam değişkeni yok! ***');
      return null; // Hata durumunda null döndür
    }
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [
      Content.text(
        '$title konusu ile ilgili bilgi içeren bir metin üret. İçeriklerin sıkıcı olmamasına, okurken kullanıcıyı sıkmamaya özen göstererek metin içerikleri yarat. Başlığın başında #,* gibi herhangi bir işaret olmasın.',
      ),
    ];
    final response = await model.generateContent(content);
    return response.text; // Yanıtı döndürüyoruz
  }
}
