import 'package:edumix/product/initialize/application_start.dart';
import 'package:edumix/product/widgets/auth_wrapper.dart';
import 'package:edumix/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(); // .env dosyasını yükle
  await ApplicationStart.init(); // Firebase'i başlat

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Durum çubuğu
        statusBarIconBrightness: Brightness.dark, // Simge rengi
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: lightTheme,
      home: AuthWrapper(),
      // home: const ProviderScope(child: RegisterView()),
    );
  }
}
