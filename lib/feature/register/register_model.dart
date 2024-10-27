import 'package:edumix/product/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterModel {
  final AuthService _authService = AuthService();

  Future<User?> register(
    String email,
    String password,
    String displayName,
  ) async {
    return _authService.registerWithEmailAndPassword(
      email,
      password,
      displayName,
    );
  }
}
