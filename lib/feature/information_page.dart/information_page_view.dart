import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InformationView extends StatelessWidget {
  const InformationView({
    required this.title,
    required this.content,
    super.key,
  });
  final String title;
  final String content;

  // Future<void> _shareContent(BuildContext context) async {
  //   // Paylaşılacak içeriği ayarla
  //   final String message = '$title\n\n$content';

  //   // İçeriği paylaş
  //   await Share.share(message);
  // }

  Future<void> _likeContent() async {
    // Mevcut kullanıcıyı al
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Firestore referansını oluştur
      final firestore = FirebaseFirestore.instance;

      // Kullanıcının 'saved' koleksiyonuna verileri ekle
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .add({
        'title': title,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });
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
                title,
                style: const TextStyle(
                  fontSize: WidgetSizes.largeTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                content,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Paylaş',
            icon: Icon(Icons.share),
          ),
          BottomNavigationBarItem(
            label: 'Beğen',
            icon: Icon(Icons.favorite),
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // _shareContent(context); // Paylaş butonuna basıldığında
          } else if (index == 1) {
            _likeContent(); // Beğen butonuna basıldığında
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Beğenildi!')),
            );
          }
        },
      ),
    );
  }
}
