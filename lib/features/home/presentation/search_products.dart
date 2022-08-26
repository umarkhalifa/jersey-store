import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/contsants/extension.dart';
import 'package:untitled/features/home/helpers/cart_icon.dart';
import 'package:untitled/features/home/helpers/popular_card.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/presentation/product_page.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';

import '../helpers/bottom_sheet.dart';

class SearchPage extends ConsumerWidget {
  final String query;

  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // !SEARCH QUERY
    String search = query;

    // SEARCHED ITEMS REF
    final items = ref.watch(searchProvider);
    return items.when(
      data: (data) {
        return Scaffold(
          body: Container(
            height: getHeight(context),
            width: getWidth(context),
            decoration: BoxDecoration(
              gradient: kGradient
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),

                // TOP BAR
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
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                       Text(
                        "Search Products",
                        style: kHead
                      ),
                      const CartIcon(),
                    ],
                  ),
                ),

                //SPACER
                const SizedBox(
                  height: 20,
                ),

                // SEARCHED ITEMS
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      //PRODUCT INSTANCE
                      Product product =
                          Product.fromJson(data.docs[index].data());
                      return data.docs[index]['CLUB']
                              .toString()
                              .startsWith(search.trim().capitalize())
                          ? ShowUpAnimation(
                              direction: Direction.horizontal,
                              child: GestureDetector(
                                onTap: () {
                                  //  NAVIGATE TO PRODUCT DETAILS
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          product: product,
                                          id: data.docs[index].id),
                                    ),
                                  );
                                },
                                child: PopularCard(
                                    callback: () {
                                        showBottom(
                                            data.docs[index].id, product, context,ref);
                                    },
                                    id: data.docs[index].id,
                                    club: product.club,
                                    image: product.image,
                                    name: product.name),
                              ),
                            )
                          : const SizedBox();
                    },
                    itemCount: data.docs.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },

      // ON SEARCH ITEMS FAIL
      error: (e, trace) {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: Colors.transparent,
          child: const Icon(Icons.error),
        );
      },

      // ON SEARCH LOADING
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: Colors.transparent,
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
