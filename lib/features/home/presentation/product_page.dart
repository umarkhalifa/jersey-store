import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/services/product_database.dart';

import '../model/cart.dart';

final selectedSize = StateProvider(
  (ref) => sizes.elementAt(0),
);
final favorite = StateProvider((ref) => false);
final amountProvider = StateProvider((ref) => 1);

class ProductPage extends ConsumerStatefulWidget {
  final Product product;
  final String id;

  const ProductPage({Key? key, required this.product, required this.id})
      : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  // !CHECK PRODUCT IS IN WISH_LIST
  checkTest() async {
    ref.read(favorite.notifier).state =
        await ref.read(productProvider).checkFavorite(widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkTest();
  }

  @override
  Widget build(BuildContext context) {
    //! SELECTED SIZE PROVIDER REF
    final size = ref.watch(selectedSize);

    //! CHECK FAVORITE PROVIDER REF
    final bool test = ref.watch(favorite);

    //! AMOUNT PROVIDER REF
    final amount = ref.watch(amountProvider);
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        decoration: BoxDecoration(
          gradient: kGradient
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              alignment: Alignment.topRight,
              height: getHeight(context) * 0.5,
              width: getWidth(context) * 0.5,
              decoration:  BoxDecoration(
                color: kBlue.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: getHeight(context) * 0.06, left: 20, right: 20,bottom: 20),
              height: getHeight(context),
              width: getWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! TOP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // ADD OR REMOVE ITEM FROM WISHLIST
                          await ref
                              .read(productProvider)
                              .addToWish(widget.product, widget.id);
                          // RESET FAVORITE PROVIDER REF
                          ref.read(favorite.notifier).state = await ref
                              .read(productProvider)
                              .checkFavorite(widget.id);
                        },
                        child: Icon(
                          test == true
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: test == true ? Colors.red : Colors.white
                        ),
                      ),
                    ],
                  ),

                  // PRODUCT IMAGES
                  SizedBox(
                    height: getHeight(context) * 0.45,
                    width: getWidth(context),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // !SHADOW IMAGE
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: Image.asset("assets/images/shadow3.png"),
                        ),

                        // PRODUCT IMAGE
                        Positioned(
                          top: 0,
                          left: 20,
                          right: 20,
                          child: SizedBox(
                              height: getHeight(context) * 0.4,
                              width: getWidth(context),
                              child: Image.network(
                                widget.product.image,
                                fit: BoxFit.contain,
                                //! IMAGE LOADING WIDGET
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: SpinKitFadingCircle(
                                      color: Colors.white,
                                    ),
                                  );
                                },

                                //! IMAGE FETCH ERROR
                                errorBuilder: (context, object, trace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.error,
                                      size: 20,
                                    ),
                                  );
                                },
                              ),),
                        ),
                      ],
                    ),
                  ),

                  // !SPACER
                  const SizedBox(
                    height: 20,
                  ),
                  // PRODUCT CLUB NAME AND PRICE TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.club,
                        style: const TextStyle(
                            fontFamily: "Medium", fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                            fontFamily: "Regular", color: Colors.grey.shade50),
                      )
                    ],
                  ),

                  //SPACER
                  const SizedBox(
                    height: 10,
                  ),

                  //PRODUCT TYPE NAME AND PRICE TAG
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                            color: Colors.grey.shade50, fontFamily: "Regular"),
                      ),
                      const Text(
                        "NGN 5000",
                        style: TextStyle(
                            fontFamily: "Medium", color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),

                  //SPACER
                  const SizedBox(
                    height: 20,
                  ),

                  // DESCRIPTION TEXT
                  Text(
                    "This is the ${widget.product.club} ${widget.product.name.toLowerCase()}for from ${widget.product.brand}.This shirt was made for the 2020/2021 season of ${widget.product.league}. This jersey is perfect for the excited ${widget.product.club} fans.",
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontFamily: "Regular",
                        fontSize: 14,
                        wordSpacing: 5),
                  ),

                  //SPACER
                  const SizedBox(
                    height: 30,
                  ),


                  // AMOUNT AND SIZE MODIFIERS
                  Row(
                    children: [
                      SizedBox(width: getWidth(context) * 0.4,child: SIZES(size: size)),
                      const Spacer(),
                      SizedBox(
                        height: 30,
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // DECREASE NUMBER OF PRODUCTS
                            GestureDetector(
                              onTap: () {
                                if (amount > 1) {
                                  ref.read(amountProvider.notifier).state--;
                                }
                              },
                              child: const CircleAvatar(
                                backgroundColor: kBlue,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),

                            // NUMBER OFF PRODUCTS
                            Text(
                              amount.toString(),
                              style: const TextStyle(fontSize: 13, color: Colors.white,fontFamily: "Medium"),
                            ),

                            // INCREASE NUMBER OF PRODUCTS
                            GestureDetector(
                              onTap: () {
                                ref.read(amountProvider.notifier).state += 1;
                              },
                              child: const CircleAvatar(
                                backgroundColor: kBlue,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const Spacer(),
                  // FAVORITE AND CART BUTTON
                  GestureDetector(
                    onTap: () async {
                      Cart cart = Cart(
                          product: widget.product,
                          size: size,
                          amount: amount);
                        await ref
                            .read(productProvider)
                            .addToCart(cart, context);
                        if (mounted) {
                         // SnackUtils.showSnackBar(myContext: context, message: "Cart updated successfully", isError: false);
                        }

                    },
                    child: Container(
                      height: getHeight(context) * 0.08,
                      width: getWidth(context),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                              color: kBlue, fontFamily: 'Medium'),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SIZES extends ConsumerWidget {
  const SIZES({
    Key? key,
    required this.size,
  }) : super(key: key);

  final String size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: sizes
            .map(
              (e) => GestureDetector(
                onTap: () {
                  ref.read(selectedSize.notifier).state = e;
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: size == e ? kRed : Colors.transparent,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: const Color(0xfff7f7f7),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: size == e ? kRed : kBlue,
                      child: Text(
                        e,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Regular",
                            fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList());
  }
}
