import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';

class AuthButton extends ConsumerWidget {
  final String title;

  const AuthButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool loading = ref.watch(loadingProvider);
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Text(
                title,
                style: const TextStyle(fontFamily: "Regular"),
              ),
      ),
    );
  }
}
