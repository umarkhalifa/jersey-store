import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/helpers/button.dart';
import 'package:untitled/features/authentication/helpers/image_background.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';
import 'package:untitled/features/authentication/services/wrapper.dart';

class VerifyEmail extends ConsumerWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthWrapper()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Center(
              child: Text(
                "Email Verification",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Bold", fontSize: 25),
              ),
            ),
            const Text(
              "A verification mail has been sent to your account. Please verify your email to login",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Regular", color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  ref.read(authenticationProvider).verifyEmail();
                },
                child: const AuthButton(title: "Verify Email"),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
