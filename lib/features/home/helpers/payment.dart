import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:untitled/contsants/snack_bar.dart';

class Payment {
  BuildContext context;
  int price;
  Future future;
  String email;


  Payment({required this.price, required this.context, required this.email,required this.future});

  // Create an instance of payStack
  PaystackPlugin payStack = PaystackPlugin();

  // Create Reference

  String _getReference() {
    String platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else {
      platform = "iOS";
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Initialize payStack
  Future initializePlugin() async {
    await payStack.initialize(publicKey: "pk_test_14188f77ca2e1cbf6e6435b1a86fa9a7afa72646");
  }

//  Get card ui
  PaymentCard _getCardUi() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

//  Charge card
  chargeCard() async {
    initializePlugin().then(
          (_) async {
        Charge charge = Charge()
          ..amount = price * 100
          ..email = email
          ..reference = _getReference()
          ..card = _getCardUi();

        CheckoutResponse response = await payStack.checkout(
          context,
          charge: charge,
          method: CheckoutMethod.card,
          fullscreen: false,
          logo: const FlutterLogo(
            size: 24,
          ),
        );
        if (response.status == true) {
          await future;
        } else {
          SnackUtils.showSnackBar(myContext: context, message: "Payment failed", isError: true);
        }
      },
    );
  }
}
