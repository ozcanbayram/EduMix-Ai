import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class startGeminiAi {
  final String? apiKey = dotenv.env['GOOGLE_GEMINI_API_KEY'];
}

Future<String?> titleGeneratorAi(String categorie) async {
  final apiKey = dotenv.env['GOOGLE_GEMINI_API_KEY'];

  if (apiKey == null) {
    print(r'$GOOGLE_GEMINI_API_KEY ortam değişkeni yok! ***');
    exit(1);
  }
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  final content = [
    Content.text(
      '$categorie konusu ile ilgili sadece bir adet başlık üret. sBaşlığın başında #,* gibi herhangi bir işaret olmasın.',
    ),
  ];
  final response = await model.generateContent(content);
  return response.text; // Yanıtı döndürüyoruz
}

Future<String?> informationCreator(String title) async {
  final apiKey = dotenv.env['GOOGLE_GEMINI_API_KEY'];
  if (apiKey == null) {
    print(r'$GOOGLE_GEMINI_API_KEY ortam değişkeni yok! ***');
    exit(1);
  }
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  final content = [
    Content.text(
      '$title konusu ile ilgili bilgi içeren bir metin üret,  İçeriklerin sıkıcı olmamasına, okurken kullanıcıyı sıkmamaya özen göstererek metin içerikleri yarat. siçeriğin içinde #,* gibi herhangi bir işaret olmasın, sadeec yazılar olsun..',
    ),
  ];
  final response = await model.generateContent(content);
  return response.text; // Yanıtı döndürüyoruz
}
