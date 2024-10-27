import 'package:edumix/feature/register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final registerProvider = StateNotifierProvider<RegisterProvider, int>((ref) {
    return RegisterProvider();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        ref.watch(registerProvider).toString(),
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
