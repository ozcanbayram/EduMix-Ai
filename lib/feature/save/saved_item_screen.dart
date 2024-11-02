import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/feature/information_page.dart/information_page_view.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/widgets/bottom_nav_bar.dart';
import 'package:edumix/product/widgets/button_small.dart';
import 'package:edumix/product/widgets/main_app_bar.dart';
import 'package:edumix/product/widgets/page_padding.dart';
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
        builder: _buildFutureBuilder,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
    );
  }

  Widget _buildFutureBuilder(
    BuildContext context,
    AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return _buildErrorMessage(snapshot.error);
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text(ProjectText.likedNotYet));
    }

    return _buildSavedItemsList(snapshot.data!);
  }

  Widget _buildSavedItemsList(List<Map<String, dynamic>> savedItems) {
    return Padding(
      padding: CustomPaddings.allMedium,
      child: ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          return _buildSavedItemCard(savedItems[index], index);
        },
      ),
    );
  }

  Card _buildSavedItemCard(Map<String, dynamic> item, int index) {
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
        trailing: _buildDeleteButton(item['id'].toString(), index),
        onTap: () => _navigateToInformationView(item),
      ),
    );
  }

  IconButton _buildDeleteButton(String itemId, int index) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () async {
        if (await _showConfirmationDialog(context)) {
          await _authService.unlikeContent(itemId);
          setState(() {
            _savedItemsFuture = _authService.fetchSavedItems();
          });
        }
      },
    );
  }

  Future<void> _navigateToInformationView(Map<String, dynamic> item) async {
    navigateTo(
      context,
      InformationView(
        title: item['title'].toString(),
        content: item['content'].toString(),
        isLiked: true,
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(ProjectText.areUSureDelete),
              actions: [
                ButtonSmall(
                  text: 'Hayır',
                  onPress: () => Navigator.of(context).pop(false),
                ),
                ButtonSmall(
                  text: 'Evet',
                  onPress: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        )) ??
        false;
  }

  Widget _buildErrorMessage(Object? error) {
    return Center(child: Text('Hata: $error'));
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    // ignore: use_build_context_synchronously
    navigateReplacementTo(context, const WelcomePage());
    // ignore: use_build_context_synchronously
    showCustomSnackBar(context, ProjectText.signedOut);
  }
}
