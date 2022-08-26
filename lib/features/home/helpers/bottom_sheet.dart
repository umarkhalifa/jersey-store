import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contsants/colors.dart';
import '../model/cart.dart';
import '../model/product.dart';
import '../services/product_database.dart';

showBottom(String? id, Product product, BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 370,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Select Size",
                    style: TextStyle(
                        color: Color(0xff111111), fontFamily: "Medium"),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Color(0xff111111),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Text(
                product.club,
                style: const TextStyle(fontFamily: "Bold"),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: sizes
                    .map(
                      (e) => Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e,
                            style:
                            const TextStyle(fontFamily: "Medium"),
                          ),
                          const Text(
                            "NGN 5000",
                            style: TextStyle(
                                fontFamily: "Regular",
                                color: Colors.grey),
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          try{
                            Cart cart = Cart(
                                product: product,
                                size: e,
                                amount: 1);
                            await ref
                                .read(productProvider)
                                .addToCart(cart, context);
                          }finally{
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kBlue),
                          child: const Center(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Regular"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        );
      });
}