import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/product/widgets/auth_text_button.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

// ignore: lines_longer_than_80_chars
class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageEnums.learning_first.toImage,
            Text(
              textAlign: TextAlign.center,
              ProjectText.firstWelcomeText,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorItems.project_text_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
            TabPageSelector(
              controller: _tabController,
              color: ColorItems.project_white,
              selectedColor: ColorItems.project_orange,
              // indicatorSize: 10,
            ),
            const Spacer(),
            ButtonLarge(
              buttonsText: ProjectText.registerButton,
              onPressed: () {},
            ),
            AuthTextButton(
              text: ProjectText.haveAccountLogin,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
