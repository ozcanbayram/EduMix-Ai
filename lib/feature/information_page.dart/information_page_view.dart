import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:flutter/material.dart';

class InformationView extends StatefulWidget {
  const InformationView({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final String content;

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  final AuthService _authService = AuthService();
  bool isLiked = false;
  String? documentId;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    isLiked = await _authService.checkIfLiked(widget.title, widget.content);
    setState(() {});
  }

  Future<void> _likeContent() async {
    final id = await _authService.removeLike(widget.title, widget.content);
    setState(() {
      isLiked = true;
      documentId = id; // Yeni documentId'yi kaydet
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Beğenildi!')),
    );
  }

  Future<void> _unlikeContent() async {
    if (documentId != null) {
      await _authService.unlikeContent(documentId!);
      setState(() {
        isLiked = false;
        documentId = null; // documentId'yi sıfırla
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Beğenilerden kaldırıldı!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: WidgetSizes.largeTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.content,
                style: const TextStyle(
                  fontSize: WidgetSizes.mediumTextSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorItems.project_scaffold_color,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            label: 'Paylaş',
            icon: Icon(Icons.share),
          ),
          BottomNavigationBarItem(
            label: isLiked ? 'Beğenilerden Kaldır' : 'Beğen',
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Paylaş butonuna basıldığında
            // _shareContent(context);
          } else if (index == 1) {
            if (isLiked) {
              _unlikeContent(); // Beğenilerden Kaldır işlemi
            } else {
              _likeContent(); // Beğen işlemi
            }
          }
        },
      ),
    );
  }
}
