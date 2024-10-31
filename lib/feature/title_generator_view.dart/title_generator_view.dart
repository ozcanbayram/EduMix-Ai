import 'package:edumix/feature/title_generator_view.dart/article_page.dart';
import 'package:edumix/product/services/ai_service.dart'; // titleGeneratorAi metodunu içeren dosya
import 'package:flutter/material.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({required this.category, super.key});
  final String category;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late String _currentTitle; // API'den gelen başlık
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategoryTitle(); // Başlığı yüklemek için çağırıyoruz
  }

  Future<void> _fetchCategoryTitle() async {
    setState(() => _isLoading = true);

    // Yapay zeka metodunu kullanarak başlık al
    final title =
        await titleGeneratorAi(widget.category); // Burada metodu kullanıyoruz

    print(title);

    setState(() {
      _currentTitle = title ??
          'Başlık Üretilirken Hata Oluştu'; // Hata durumunda varsayılan metin
      _isLoading = false;
    });
  }

  // Başlığı yeniden oluşturma metodu
  Future<void> _refreshTitle() async {
    await _fetchCategoryTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onHorizontalDragEnd: (_) =>
                  _refreshTitle(), // Card'ı kaydırınca başlığı değiştir
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _currentTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              // ignore: inference_failure_on_instance_creation
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticlePage(title: _currentTitle),
                              ),
                            );
                          },
                          child: const Text('Bu Konuyu Oku'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
