import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/feature/information_page.dart/information_page_view.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/button_small.dart';
import 'package:edumix/product/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  _SavedItemsScreenState createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  late Future<List<Map<String, dynamic>>> _savedItemsFuture;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _savedItemsFuture = _authService.fetchSavedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(onLogout: _signOut),
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
                          await _authService
                              .unlikeContent(item['id'].toString());
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
                          isLiked: true,
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

  //! Metotlar

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Silmek istediğinize emin misiniz?'),
              actions: [
                ButtonSmall(
                  text: 'Hayır',
                  onPress: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                ButtonSmall(
                  text: 'Evet',
                  onPress: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    navigateReplacementTo(context, const WelcomePage());
    showCustomSnackBar(context, ProjectText.signedOut);
  }
}
