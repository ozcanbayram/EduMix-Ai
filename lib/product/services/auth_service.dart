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

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('saved')
          .doc('initial')
          .set({});

      return userCredential.user;
    } catch (e) {
      print(e);
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
      print('Hata: ${e.message}');
      return null;
    } catch (e) {
      print('Beklenmedik bir hata: $e');
      return null;
    }
  }

  // Parolayı sıfırla
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Parola sıfırlama e-postası gönderildi.');
    } on FirebaseAuthException catch (e) {
      print('Hata: ${e.message}');
    }
  }

  // Mevcut kullanıcıyı al
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Kullanıcı çıkış işlemi
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Kullanıcı adını Firestore'dan al
  Future<String?> getUserName() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        return userDoc.data()?['displayName'] as String?;
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
    return null;
  }

  // Kullanıcının beğenip beğenmediğini kontrol et
  Future<bool> checkIfLiked(String title, String content) async {
    final user = _auth.currentUser;
    if (user != null) {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved')
          .where('title', isEqualTo: title)
          .where('content', isEqualTo: content)
          .get();

      return querySnapshot.docs.isNotEmpty;
    }
    return false;
  }

  // İçeriği beğen
  Future<void> likeContent(String title, String content) async {
    final user = _auth.currentUser;
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
      await FirebaseFirestore.instance
          .collection('saved_items')
          .doc(documentId)
          .delete();
    } catch (e) {
      print('Error removing content: $e');
      rethrow; // Hata durumunu yukarı fırlat
    }
  }

  // Kaydedilenleri çek
  Future<List<Map<String, dynamic>>> fetchSavedItems() async {
    final user = _auth.currentUser;
    if (user == null) {
      return [];
    }

    final savedItemsSnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('saved')
        .get();

    return savedItemsSnapshot.docs.map((doc) => doc.data()).toList();
  }
}
