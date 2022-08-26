import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/features/home/presentation/cart.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // !CART STREAM PROVIDER
    final length = ref.watch(cartStream);

    return SizedBox(
      width: 35,
      height: 35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          //! CART ICON
          GestureDetector(
            onTap: () {
              ref.refresh(priceProvider);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            child: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
          ),

          // !CART NUMBER BUBBLE
          Positioned(
            top: 5,
            right: 6,
            child: CircleAvatar(
              backgroundColor: kRed,
              radius: 6,
              child: Text(
                "${length.value?.docs.length}",
                style: const TextStyle(
                    fontFamily: "Regular", fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
