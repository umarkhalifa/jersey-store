import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/drawer/drawer.dart';
import 'package:untitled/features/home/helpers/address_details.dart';
import 'package:untitled/features/home/helpers/shipment_details.dart';
import 'package:untitled/features/home/presentation/shipping_page.dart';

import '../../authentication/services/authentication.dart';
import '../helpers/payment.dart';
import '../repositories/product_repositories.dart';
import '../services/product_database.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final price = ref.watch(priceProvider);
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        decoration: BoxDecoration(gradient: kGradient),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //  !TOP BAR
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  GO BACK ICON
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                  //  PAGE HEADER
                  Text(
                    "Checkout",
                    style: kHead,
                  ),

                  //  THERE TO CENTER PAGE HEADER
                  const SizedBox(width: 20),
                ],
              ),
            ),

            //  ADDRESS HEADER
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  ADDRESS HEADER
                  const Text(
                    "Address Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Regular",
                    ),
                  ),

                  // EDIT ADDRESS BUTTON
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShippingPage()),
                          (route) => false);
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(
                          fontFamily: "Regular", color: Colors.grey.shade200),
                    ),
                  ),
                ],
              ),
            ),

            //DIVIDER
            const Divider(),

            // ADDRESS DETAILS
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: AddressDetails(),
            ),
            //DIVIDER
            const Divider(),

            //  SHIPMENT HEADER,
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Shipment Details",
                style: TextStyle(color: Colors.white, fontFamily: "Medium"),
              ),
            ),
            //  SHIPMENT DETAILS
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ShipmentDetails(),
            ),
            //SPACER
            const SizedBox(
              height: 10,
            ),
            //  SUBTOTAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SUBTOTAL",
                    style: TextStyle(
                        fontFamily: 'Regular', color: Colors.grey.shade50),
                  ),
                  Text(
                    price.value.toString(),
                    style: const TextStyle(fontFamily: 'Medium', color: Colors.white),
                  )
                ],
              ),
            ),
            // SPACER
            const SizedBox(
              height: 10,
            ),

            // DIVIDER
            const Divider(),
            //SPACER
            const SizedBox(
              height: 10,
            ),
            //  SUBTOTAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SHIPPING(Abuja)",
                    style: TextStyle(
                        fontFamily: 'Regular', color: Colors.grey.shade50),
                  ),
                  const Text(
                    "NGN 1,300",
                    style: TextStyle(fontFamily: 'Medium', color: Colors.white),
                  )
                ],
              ),
            ),
            //SPACER
            const SizedBox(
              height: 10,
            ),
            //  DIVIDER
            const Divider(),
            // SPACER
            const SizedBox(
              height: 10,
            ),
            //  TOTAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(
                        fontFamily: 'Regular', color: Colors.grey.shade50),
                  ),
                  Text(
                    "${price.value! + 1300}",
                    style: const TextStyle(fontFamily: 'Medium', color: Colors.white),
                  ),
                ],
              ),
            ),
            //SPACER
            const SizedBox(
              height: 10,
            ),

            //  PAYMENT BUTTON
            GestureDetector(
              onTap: () async {
                Payment(
                        price: price.value! + 1300,
                        context: context,
                        email: "${Authentication().current?.email}",
                        future: ref.read(productProvider).addOrder())
                    .chargeCard();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: getHeight(context) * 0.07,
                  width: getWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Proceed to payment",
                      style:
                          TextStyle(fontFamily: "Medium", color: kBlue),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
