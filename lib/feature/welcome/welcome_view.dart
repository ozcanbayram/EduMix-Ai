import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/login/login_view.dart';
import 'package:edumix/feature/register/register_view.dart';
import 'package:edumix/feature/welcome/welcome_model.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/widgets/auth_text_button.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:edumix/product/widgets/welcome_pages_widgets.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    //Ekran acilinca gerekli initilaze işlemleri.
    super.initState();
    initializeControllers();
  }

  void initializeControllers() {
    // TabController ve PageController baslat
    _tabController = TabController(
      length: WelcomeElements.welcomeItems.length,
      vsync: this,
    );

    _pageController = PageController();

    // TabController'i dinle ve sayfa geçişi
    // TabController'ın indexi ile PageController'ın page değerleri aynı.
    _tabController.addListener(syncTabWithPage);
  }

  void syncTabWithPage() {
    if (_tabController.indexIsChanging) {
      _pageController.jumpToPage(_tabController.index);
    }
  }

  // widget'in işi kalmadiginda yer kaplamasın diye.
  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageViewWelcome(
                pageController: _pageController,
                onPageChanged: (index) => _tabController.animateTo(index),
                // (index): yeni sayfanın sırasini alir ve
                //tabController'i günceller
              ),
            ),
            WelcomeSelector(tabController: _tabController),
            ButtonLarge(
              buttonsText: ProjectText.registerButton,
              onPressed: () {
                navigateTo(context, const RegisterView());
              },
            ),
            AuthTextButton(
              text: ProjectText.haveAccountLogin,
              onPressed: () {
                navigateTo(context, const LoginView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
