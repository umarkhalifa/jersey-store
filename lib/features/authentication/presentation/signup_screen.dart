import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/helpers/button.dart';
import 'package:untitled/features/authentication/helpers/auth_form.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';

import '../helpers/image_background.dart';

class SignUpScreen extends ConsumerWidget {
  final VoidCallback toggle;

  SignUpScreen({Key? key, required this.toggle}) : super(key: key);
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    bool loading = ref.watch(loadingProvider);
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 20, bottom: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.15,
                  ),
                  const Text(
                    "Create Account!",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Bold', fontSize: 25),
                  ),
                  const Text(
                    "Sign up to continue",
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Regular'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthForm(
                      hint: "Full Name",
                      name: "Name",
                      iconData: Icons.person,
                      controller: name),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthForm(
                      hint: "Email Address",
                      name: "Email Address",
                      iconData: Icons.mail,
                      controller: email),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthForm(
                      hint: "Phone Number",
                      name: "Phone Number",
                      iconData: Icons.phone,
                      controller: phone),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthForm(
                      hint: "Password",
                      name: "Password",
                      iconData: Icons.lock,
                      controller: password),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          ref.read(loadingProvider.notifier).state = !loading;
                          await ref.read(authenticationProvider).signUpWithEmail(
                              name.text.trim(),
                              email.text.trim(),
                              password.text.trim(),
                              context,
                              phone.text.trim());

                          ref.refresh(loadingProvider);
                          await ref.read(authenticationProvider).verifyEmail();

                        } else {
                          // showFailed("Ensure all fields are filled", context);
                        }
                      },
                      child: const AuthButton(title: "Sign Up")),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an Account? ",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Regular"),
                      ),
                      TextButton(
                        onPressed: toggle,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Regular"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
