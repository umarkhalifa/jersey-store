import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/presentation/login_screen.dart';
import 'package:untitled/features/authentication/presentation/signup_screen.dart';

final isLogin = StateProvider((ref) => true);

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool login = ref.watch(isLogin);
    if (login == true) {
      return LoginScreen(
        toggle: () {
          ref.read(isLogin.notifier).state = false;
          },
      );
    } else {
      return SignUpScreen(
        toggle: () {
          ref.read(isLogin.notifier).state = true;
        },
      );
    }
  }
}
