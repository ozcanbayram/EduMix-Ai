import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//kayit:
  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      // E-posta ve şifre ile kullanıcı kaydı
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcı bilgilerini Firestore'a kaydet
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'displayName': displayName, // Kullanıcının adı
      });

      // Boş bir 'saved' koleksiyonu oluştur
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('saved')
          .doc('initial')
          .set({});

      return userCredential.user; // Başarılı ise kullanıcıyı döndür
    } catch (e) {
      print(e);
      return null; // Hata durumunda null
    }
  }

  //Giriş:
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Hata yönetimi
      switch (e.code) {
        case 'user-not-found':
          print('Kullanıcı bulunamadı.');
        case 'wrong-password':
          print('Yanlış parola.');
        default:
          print('Bir hata oluştu: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Beklenmedik bir hata oluştu: $e');
      return null;
    }
  }

  //forgot password:
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Parola sıfırlama e-postası gönderildi.');
    } on FirebaseAuthException catch (e) {
      // Hata yönetimi
      print('Hata: ${e.message}');
    }
  }

  //kullanici durumu:
  User? getCurrentUser() {
    return _auth.currentUser;
  }

//cikis islemi:
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
