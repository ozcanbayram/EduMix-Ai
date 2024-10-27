import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterProvider extends StateNotifier<int> {
  RegisterProvider() : super(0);

  void increment() => state++;
}
