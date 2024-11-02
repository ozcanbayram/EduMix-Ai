import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool isLiked = false;
  String? documentId;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .where('title', isEqualTo: widget.title)
          .where('content', isEqualTo: widget.content)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          isLiked = true;
          documentId = querySnapshot.docs.first.id; // documentId'yi al
        });
      }
    }
  }

  Future<void> _likeContent() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firestore = FirebaseFirestore.instance;

      final docRef = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .add({
        'title': widget.title,
        'content': widget.content,
        'isLiked': true,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        isLiked = true;
        documentId = docRef.id; // Yeni documentId'yi kaydet
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Beğenildi!')),
      );
    }
  }

  Future<void> _unlikeContent() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && documentId != null) {
      final firestore = FirebaseFirestore.instance;

      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .doc(documentId)
          .delete();

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
