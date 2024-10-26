  import 'package:edumix/core/constants/color_items.dart';
  import 'package:edumix/core/constants/project_text.dart';
  import 'package:edumix/feature/welcome/page_view_welcome.dart';
  import 'package:edumix/feature/welcome/welcome_model.dart';
  import 'package:edumix/product/widgets/auth_text_button.dart';
  import 'package:edumix/product/widgets/button_large.dart';
  import 'package:edumix/product/widgets/page_padding.dart';
  import 'package:flutter/material.dart';
  import 'package:kartal/kartal.dart';

  class WelcomePage extends StatefulWidget {
    const WelcomePage({super.key});

    @override
    State<WelcomePage> createState() => _WelcomePageState();
  }

  class _WelcomePageState extends State<WelcomePage>
      with SingleTickerProviderStateMixin {
    //tabPageController:
    late final TabController _tabController;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(
        length: WelcomeElements.welcomeItems.length,
        vsync: this, //Requires with SingleTickerProviderStateMixin
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(ProjectText.appName),
        ),
        body: Padding(
          padding: const PagePadding.all(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: PageViewWelcome(),
              ),
              Padding(
                padding: context.padding.normal,
                child: TabPageSelector(
                  controller: _tabController,
                  color: ColorItems.project_white,
                  selectedColor: ColorItems.project_orange,
                  // indicatorSize: 10,
                ),
              ),
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
