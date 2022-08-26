import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';

import '../../../contsants/colors.dart';
import '../helpers/cart_icon.dart';

class OrderHistory extends ConsumerWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ORDERS PROVIDER REF
    final orders = ref.watch(orderProvider);

    return orders.when(
      data: (data) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            height: getHeight(context),
            width: getWidth(context),
            decoration: BoxDecoration(
              gradient: kGradient
            ),
            child: Column(
              children: [
                //! TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ZoomDrawer.of(context)?.toggle();
                      },
                      child: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Order History",
                      style: TextStyle(fontFamily: 'Medium', color: Colors.white),
                    ),
                    const CartIcon(),
                  ],
                ),

                // ORDERED ITEMS LIST
                Expanded(
                  child: ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 500),
                    direction: Direction.horizontal,
                    delayStart: const Duration(milliseconds: 200),
                    child: data.docs.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              Product product = Product.fromJson(
                                  data.docs[index]['PRODUCT']);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: getHeight(context) * 0.14,
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Positioned(
                                        bottom: 5,
                                        right: 0,
                                        left: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Container(
                                            height: getHeight(context) * 0.1,
                                            width: getWidth(context),
                                            padding: EdgeInsets.only(
                                                left: getWidth(context) * 0.2,
                                                top: 30,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                              color: kBlue.withOpacity(0.65),

                                              //! SHADOW EFFECT
                                              boxShadow: [
                                                BoxShadow(
                                                    color: kBlue.withOpacity(0.1),
                                                    offset: const Offset(0, 5),
                                                    blurRadius: 7),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        product.club
                                                            .toUpperCase(),
                                                        style:
                                                            const TextStyle(
                                                                fontFamily:
                                                                    "Medium",
                                                                color: Colors.white),
                                                      ),
                                                      SizedBox(
                                                        width: getWidth(
                                                                context) -
                                                            170,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              product.name,
                                                              style:  TextStyle(
                                                                  fontFamily:
                                                                      "Regular",
                                                                  color: Colors
                                                                      .grey.shade200,
                                                                  fontSize:
                                                                      13),
                                                            ),
                                                            Container(
                                                                height: 25,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        7),
                                                                decoration: BoxDecoration(
                                                                    color: data.docs[index]
                                                                            [
                                                                            'STATUS']
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .orange,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Text(
                                                                  data.docs[index]
                                                                          [
                                                                          'STATUS']
                                                                      ? "DELIVERED"
                                                                      : "PROCESSING"
                                                                          .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          "Regular",
                                                                      fontSize:
                                                                          8,
                                                                      color: Colors
                                                                          .white),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: SizedBox(
                                          height: getHeight(context) * 0.11,
                                          width: getWidth(context) * 0.3,
                                          child: Image.network(
                                            product.image,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                child: SpinKitFadingCircle(
                                                  color: kBlue,
                                                ),
                                              );
                                            },
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
                                      Positioned(
                                        left: 25,
                                        bottom: 5,
                                        child: SizedBox(
                                          width: 70,
                                          height: 30,
                                          child: Image.asset(
                                              "assets/images/shadow.png"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: data.docs.length,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.access_time_outlined,
                                size: 50,
                                color: kBlue,
                              ),
                              Text(
                                'No order has been made',
                                style: TextStyle(fontFamily: "Regular"),
                              )
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },

      // ON ITEMS FETCH ERROR
      error: (e, trace) {
        return SizedBox(
          height: getHeight(context),
          width: getWidth(context),
          child: const Icon(Icons.error),
        );
      },

      // ON ITEMS LOADING
      loading: () {
        return SizedBox(
          height: getHeight(context),
          width: getWidth(context),
          child: const Center(
            child: SpinKitFadingCircle(
              color: kBlue,
            ),
          ),
        );
      },
    );
  }
}
