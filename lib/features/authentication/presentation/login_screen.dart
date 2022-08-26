import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/helpers/button.dart';
import 'package:untitled/features/authentication/helpers/auth_form.dart';
import 'package:untitled/features/authentication/helpers/image_background.dart';
import 'package:untitled/features/authentication/presentation/forgot_password.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  final VoidCallback toggle;

  LoginScreen({Key? key, required this.toggle}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    bool loading = ref.watch(loadingProvider);
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, bottom: 20, right: 20, left: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.22,
                  ),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Bold", fontSize: 25),
                  ),
                  const Text(
                    "Sign in to continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Regular",
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  AuthForm(
                      controller: emailController,
                      hint: "Email Address",
                      name: "Email Address",
                      iconData: Icons.email),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  AuthForm(
                      controller: passwordController,
                      hint: "Password",
                      name: "Password",
                      iconData: Icons.lock),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Regular"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        ref.read(loadingProvider.notifier).state = !loading;
                        await auth
                            .signInWithEmail(emailController.text.trim(),
                                passwordController.text.trim(), context);
                      } else {}
                    },
                    child: const AuthButton(
                      title: "Sign In",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            color: Colors.grey.shade100, fontFamily: "Regular"),
                      ),
                      TextButton(
                        onPressed: toggle,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Regular"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
