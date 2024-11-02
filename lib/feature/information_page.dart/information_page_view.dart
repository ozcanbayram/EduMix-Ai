import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  Future<void> _deleteSavedItem(String itemId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Firebase'deki kaydedilen öğeyi sil
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .doc(itemId)
          .delete();
    }
  }

  Future<void> _toggleLike() async {
    if (isLiked) {
      // İçeriği beğenilerden kaldır
      final savedItems = await _authService.fetchSavedItems();
      final documentId = savedItems.firstWhere(
        (item) =>
            item['title'] == widget.title && item['content'] == widget.content,
        orElse: () => {}, // Varsayılan değer
      )['id'];

      if (documentId != null) {
        await _authService.unlikeContent(documentId.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('İçerik beğenilerden kaldırıldı!')),
        );
      }
    } else {
      // İçeriği beğen
      await _authService.likeContent(widget.title, widget.content);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İçerik beğenildi!')),
      );
    }

    setState(() {
      isLiked = !isLiked; // Butona tıklandığında beğeni durumunu değiştir
    });
  }

  void _shareContent() {
    // Paylaşma işlemi burada yapılacak.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('İçerik paylaşıldı!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detaylar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: WidgetSizes.largeTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.content,
                style: const TextStyle(
                  fontSize: WidgetSizes.mediumTextSize,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorItems.project_scaffold_color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
              onPressed: _toggleLike,
              color: isLiked ? Colors.red : null,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareContent,
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context); // Ana sayfaya yönlendirme
              },
            ),
          ],
        ),
      ),
    );
  }
}
