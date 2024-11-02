import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/feature/information_page.dart/information_page_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  _SavedItemsScreenState createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  late Future<List<Map<String, dynamic>>> _savedItemsFuture;

  @override
  void initState() {
    super.initState();
    _savedItemsFuture = _fetchSavedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
        leading: Padding(
          padding: const PagePadding.all(),
          child: ImageEnums.logo.toImage,
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _savedItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Henüz beğenilen içerik yok.'));
          }

          final savedItems = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                final item = savedItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      item['title'].toString(),
                      style: const TextStyle(
                        fontSize: WidgetSizes.largeTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['content'].toString(),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: WidgetSizes.mediumTextSize,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirmed =
                            await _showConfirmationDialog(context);
                        if (confirmed) {
                          await _deleteSavedItem(item['id'].toString());
                          setState(() {
                            savedItems.removeAt(index);
                          });
                        }
                      },
                    ),
                    onTap: () {
                      navigateTo(
                        context,
                        InformationView(
                          title: item['title'].toString(),
                          content: item['content'].toString(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 2,
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchSavedItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return []; // Kullanıcı giriş yapmamışsa boş liste döndür
    }

    final savedItemsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('saved')
        .get();

    // Doküman ID'sini de map içerisine ekle
    return savedItemsSnapshot.docs
        .map(
          (doc) => {
            ...doc.data(),
            'id': doc.id, // Doküman ID'si
          },
        )
        .toList();
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

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Silmek istediğinize emin misiniz?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Hayır'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Evet'),
                ),
              ],
            );
          },
        ) ??
        false; // Kullanıcı dialog'u kapatırsa varsayılan olarak "false" döndür
  }
}
