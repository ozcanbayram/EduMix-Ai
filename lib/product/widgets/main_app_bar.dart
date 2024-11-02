import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    required this.onLogout,
    super.key,
  });
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const PagePadding.all(),
        child: ImageEnums.logo.toImage, // Logoyu buraya ekleyin
      ),
      title: const Text(ProjectText.appName),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: onLogout,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
