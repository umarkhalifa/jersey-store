import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/presentation/checkout_page.dart';
import 'package:untitled/features/home/presentation/product_page.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';
import 'package:untitled/features/home/services/product_database.dart';

import '../../../contsants/colors.dart';
import '../helpers/cart_icon.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // CART PROVIDER REF
    final cartProvider = ref.watch(cartStream);
    final price = ref.watch(priceProvider);

    return cartProvider.when(
      data: (data) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 60,),

            height: getHeight(context),
            width: getWidth(context),
            decoration: BoxDecoration(
              gradient: kGradient
            ),
            child: Column(
              children: [
                //! TOP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      const Text(
                        "Cart",
                        style: TextStyle(fontFamily: 'Medium', color: Colors.white),
                      ),
                      const CartIcon(),
                    ],
                  ),
                ),

                //! CART ITEMS LIST
                Expanded(
                    child: data.docs.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              //! PRODUCT MODEL INSTANCE
                              Product product = Product.fromJson(
                                  data.docs[index]['PRODUCT']);
                              return GestureDetector(
                                onTap: () {
                                  //! PUSH SCREEN TO PRODUCT DETAIL PAGE
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          product: product,
                                          id: product.image),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: SizedBox(
                                    height: getHeight(context) * 0.14,
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        // !POPULAR CARD CONTAINER DECORATOR
                                        Positioned(
                                          bottom: 5,
                                          right: 0,
                                          left: 0,
                                          child: Dismissible(
                                            key: UniqueKey(),
                                            direction:
                                                DismissDirection.horizontal,
                                            onDismissed: (direction) async {
                                              ref
                                                  .read(productProvider)
                                                  .removeFromCart(context,
                                                      data.docs[index].id);
                                              ref.refresh(priceProvider);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Container(
                                                height:
                                                    getHeight(context) * 0.1,
                                                width: getWidth(context),
                                                padding: EdgeInsets.only(
                                                    left: getWidth(context) *
                                                        0.2,
                                                    top: 10,
                                                    bottom: 10,right: 15),
                                                decoration: BoxDecoration(
                                                  color: kBlue.withOpacity(0.65),

                                                  //! SHADOW EFFECT
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            kBlue.withOpacity(
                                                                0.05),
                                                        offset: const Offset(
                                                            0, 5),
                                                        blurRadius: 7),
                                                  ],

                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        //! PRODUCT CLUB NAME
                                                        Text(
                                                          product.club
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      "Medium",
                                                                  color:
                                                                      Colors.white),
                                                        ),

                                                        //! PRODUCT CLUB TYPE
                                                        Text(
                                                          product.name,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "Regular",
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${data.docs[index]['AMOUNT'].toString()}X ",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      "Regular",
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13),
                                                            ),
                                                            Text(
                                                              data.docs[index]
                                                                      ['SIZE']
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      "Regular",
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    // INCREMENT PRODUCT
                                                    GestureDetector(
                                                      onTap: () {
                                                        ref.read(productProvider)
                                                            .incrementCart(
                                                                data
                                                                    .docs[
                                                                        index]
                                                                    .id);
                                                        ref.refresh(priceProvider);
                                                      },
                                                      child: Container(
                                                        height: 55,
                                                        width: 55,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white,

                                                          //! SHADOW EFFECT
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: kBlue
                                                                  .withOpacity(
                                                                      0.1),
                                                              blurRadius: 10,
                                                              offset:
                                                                  const Offset(
                                                                      0, 5),
                                                            ),
                                                          ],
                                                        ),
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 19,
                                                          color: kBlue,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //! PRODUCT IMAGE
                                        Positioned(
                                          top: 0,
                                          child: SizedBox(
                                            height: getHeight(context) * 0.11,
                                            width: getWidth(context) * 0.3,
                                            child: Image.network(
                                              product.image,

                                              //! IMAGE LOADING WIDGET
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
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
                                              errorBuilder:
                                                  (context, object, trace) {
                                                return const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    size: 20,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),

                                        //! SHADOW IMAGE
                                        Positioned(
                                          left: 25,
                                          bottom: 5,
                                          child: SizedBox(
                                            width: 70,
                                            height: 30,
                                            child: Image.asset(
                                                "assets/images/shadow.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: data.docs.length,
                            //  !IF CART IS EMPTY
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment:  MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Cart is empty",
                                  style: TextStyle(fontFamily: "Regular",color: Colors.white),
                                )
                              ],
                            ),
                          )),
                Container(
                  height: getHeight(context) * 0.2,
                  width: getWidth(context),
                  padding: const EdgeInsets.all(20),
                  color: kBlue.withOpacity(0.65),
                  child: Column(
                    children: [
                      //ITEM NUMBER AND PRICE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total(${data.docs.length} items) :",
                            style: const TextStyle(
                                fontFamily: 'Regular', color: Colors.white),
                          ),
                          price.value != null ?Text(
                            price.value.toString(),
                            style: const TextStyle(
                                fontFamily: 'Medium', color: Colors.white),
                          ): const CircularProgressIndicator(color: kBlue,)
                        ],
                      ),
                      //SPACER
                      const Spacer(),
                      // CHECKOUT BUTTON
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage(),),);
                        },
                        child: Container(
                          height: getHeight(context) * 0.07,
                          width: getWidth(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "Proceed to checkout",
                              style: TextStyle(
                                  fontFamily: "Medium", color:kBlue),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },

      // !ON FETCH ERROR
      error: (e, trace) {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: kBackground,
          child: const Icon(Icons.error),
        );
      },
      //! CART LOADING WIDGET
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: kBackground,
          child: const Center(
            child: SpinKitDancingSquare(
              color: kBlue,
            ),
          ),
        );
      },
    );
  }
}
