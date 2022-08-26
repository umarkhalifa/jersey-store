import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/drawer/drawer.dart';
import 'package:untitled/features/authentication/presentation/verify_email.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';
import 'package:untitled/features/authentication/services/wrapper.dart';

import '../../../contsants/colors.dart';

class AuthStream extends ConsumerWidget {
  const AuthStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authenticationState);
    return auth.when(
      data: (data) {
        if ( data!.emailVerified) {
          return const Zoom();
        } else if (data.emailVerified == false) {
          return const VerifyEmail();
        } else {
          return const AuthWrapper();
        }
      },
      // ON ITEMS FETCH ERROR
      error: (e, trace) {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          decoration: BoxDecoration(
              gradient: kGradient
          ),
          child: const Icon(Icons.error),
        );
      },

      //WHEN ITEMS LOADING
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          decoration: BoxDecoration(
              gradient: kGradient
          ),
          child: const Center(
            child: SpinKitFadingCircle(
                color: Colors.white
            ),
          ),
        );
      },
    );
  }
}
