import 'package:edumix/product/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel {
  final AuthService _authService = AuthService();

  Future<User?> login(String email, String password) async {
    return _authService.signInWithEmailAndPassword(email, password);
  }
}
