import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/helpers/Button.dart';
import 'package:untitled/features/authentication/helpers/image_background.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';
import 'package:untitled/features/authentication/services/authentication.dart';

import '../helpers/auth_form.dart';

class ForgotPassword extends ConsumerWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool loading = ref.watch(loadingProvider);
    return Scaffold(
      body: BackgroundImage(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: "Bold"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Enter your email to reset your password",
                  style: TextStyle(color: Colors.white, fontFamily: "Regular"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                  child: AuthForm(
                      hint: "Email Address",
                      name: "Email Address",
                      iconData: Icons.mail,
                      controller: email)),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: ()async{
                  if(_formKey.currentState!.validate()){
                    ref.read(loadingProvider.notifier)
                        .state = !loading;
                    await Authentication().resetPassword(email.text.trim(), context);
                    ref.refresh(loadingProvider);
                  }

                },
                child: const AuthButton(title: "ForgotPassword"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
