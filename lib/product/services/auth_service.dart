import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
