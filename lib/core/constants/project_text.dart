import 'package:flutter/material.dart';

@immutable // içerisinde degisken tanımlanmaması için
class ProjectText {
  const ProjectText._(); // Sadece sınıf içeinden erişilebilir.

  //! MAIN TEXTS

  static const String appName = 'EduMix';

  //! ON BOARD TEXTS

  static const String firstWelcomeText =
      'Yapay zeka taradınfan oluşturulan \nsayısız bilgi EduMix’te.';

  static const String secondWelcomeText =
      'EduMix ile bir çok kategoride \nhızlıca bilgi edinebilirsin.';

  static const String thirdWelcomeText =
      'Bilgi her zaman vardır \nsadece onu bulmanı bekler. ';

  //! AUTH SCREENS TEXTS

  static const String haveAccountLogin = 'Zaten bir hesabın var mı? Giriş Yap';
  static const String registerButton = 'Kayıt Ol';
  static const String loginButton = 'Giriş Yap';
  static const String name = 'Ad Soyad';
  static const String email = 'E posta';
  static const String password = 'Parola';
  static const String passwordAgain = 'Parola Tekrar';
  static const String forgotPassword = 'Parolamı Unuttum';
  static const String sendEmail = 'E posta Gönder';
  static const String forgotPasswordText =
      'E-posta adresine parolanı yenilemen \niçin bir bağlantı göndereceğiz.';

  //! AUTH METHODS TEXTS
  static const warningEmptyInput = 'Bilgiler boş bırakılamaz.';
  static const warningPasswordControll = 'Parolalar aynı değil.';
  static const warningEmptyEmail = 'E-posta adresi boş olamaz.';
  static const successRegister = 'Kayıt Başarılı';
  static const successLogin = 'Giriş Başarılı';
  static const signedOut = 'Çıkış Yapıldı';
  static const failedRegister =
      'Kayıt başarısız oldu daha sonra tekrar deneyin.';
  static const failedLogin =
      'Giriş yapılamadı. Lütfen bilgilerinizi kontrol edin.';
  static const sendedResetPasswordConnection =
      'Parola sıfırlama e-postası gönderildi.';

  //! Home Screens texts:
  static const subtitleDescription =
      ' hakkında yapay zeka tarafından sunulan sınırsız bilgi için sadece tıkla.';

  static const categoriestNotFound = 'Kategoriler bulunamadı.';

  //! Search Screen Text:
  static const searchText = 'Kategori ara';

//! Title GeneratorPage:
  static const readThisAbout = 'Yazının Devamını Oku';
  static const errorTitleGenerator = 'Başlık Üretilirken Hata Oluştu';
  static const failCreateContent = 'İçerik üretilemedi';
  static const refreshAbout = 'Başka Konu Öner';

  //! Liked Page:
  static const likedNotYet = 'Henüz beğenilen içerik yok.';
  static const areUSureDelete = 'Silmek istediğinize emin misiniz?';

  //! Bottom Nav Bar:
  static const home = 'Anasayfa';
  static const search = 'Kategori Ara';
  static const likes = 'Beğeniler';

  //! LoadingWidgets
  static const firstAnimationUrl =
      'https://lottie.host/c3a288a2-a8c2-4887-9623-0eb730256bfb/QepoZQEDa0.json';

  static const searchAnimationUrl =
      'https://lottie.host/c4bb20e8-5175-4d59-bd3e-9fc2c3ba6941/RoAOEbKWZh.json';
}
