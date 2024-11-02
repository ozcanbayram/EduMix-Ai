import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcıyı kaydet
  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'displayName': displayName,
      });

      await _createInitialSavedCollection(userCredential.user!.uid);

      return userCredential.user;
    } catch (e) {
      print('Kayıt sırasında hata: $e');
      return null;
    }
  }

  // Kullanıcıyı giriş yap
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
      print('Giriş hatası: ${e.message}');
      return null;
    }
  }

  // Parolayı sıfırla
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Parola sıfırlama e-postası gönderildi.');
    } catch (e) {
      print('Parola sıfırlama sırasında hata: $e');
    }
  }

  // Mevcut kullanıcıyı al
  User? getCurrentUser() => _auth.currentUser;

  // Kullanıcı çıkış işlemi
  Future<void> signOut() async => _auth.signOut();

  // İçeriği beğen
  Future<void> likeContent(String title, String content) async {
    final user = getCurrentUser();
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .add({
        'title': title,
        'content': content,
        'isLiked': true,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  // İçeriği beğenilerden kaldır
  Future<void> unlikeContent(String documentId) async {
    try {
      final user = getCurrentUser();
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('saved')
            .doc(documentId)
            .delete();
      }
    } catch (e) {
      print('İçerik kaldırılırken hata: $e');
      rethrow; // Hata durumunu yukarı fırlat
    }
  }

  // Kaydedilenleri çek
  Future<List<Map<String, dynamic>>> fetchSavedItems() async {
    final user = getCurrentUser();
    if (user == null) return [];

    final savedItemsSnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('saved')
        .get();

    return savedItemsSnapshot.docs
        .map(
          (doc) => {
            ...doc.data(),
            'id': doc.id, // Doküman ID'si
          },
        )
        .toList();
  }

  // Kullanıcının başlangıçta kaydedilenler koleksiyonunu oluştur
  Future<void> _createInitialSavedCollection(String userId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('saved')
        .doc('initial')
        .set({});
  }

  //? Kullanıcı adını Firestore'dan al --> Henüz kullanılmıyor
  // Future<String?> getUserName() async {
  //   try {
  //     final user = getCurrentUser();
  //     if (user != null) {
  //       final userDoc =
  //           await _firestore.collection('users').doc(user.uid).get();
  //       return userDoc.data()?['displayName'] as String?;
  //     }
  //   } catch (e) {
  //     print('Kullanıcı adı alınırken hata: $e');
  //   }
  //   return null;
  // }
}
