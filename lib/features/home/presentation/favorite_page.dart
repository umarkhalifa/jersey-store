import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:untitled/features/home/helpers/bottom_sheet.dart';
import 'package:untitled/features/home/helpers/popular_card.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/presentation/product_page.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';
import 'package:untitled/features/home/services/product_database.dart';

import '../../../contsants/colors.dart';
import '../helpers/cart_icon.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {


    // FAVORITE PROVIDER REF
    final favorites = ref.watch(favoriteProvider);

    return favorites.when(
      data: (data) {
        return Scaffold(
          body: Container(
            height: getHeight(context),
            width: getWidth(context),
            decoration: BoxDecoration(
              gradient: kGradient
            ),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
                        color: Colors.white
                      ),
                    ),
                     Text(
                      "Favorites",
                      style: kHead,
                    ),
                    const CartIcon(),
                  ],
                ),

                //! FAVORITE ITEMS LIST
                Expanded(
                  child: ShowUpAnimation(
                      direction: Direction.horizontal,
                      animationDuration: const Duration(milliseconds: 400),
                      child: data.docs.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Product product = Product.fromJson(
                                    data.docs[index]['PRODUCT']);
                                return Dismissible(
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (direction) async {
                                    await ref
                                        .read(productProvider)
                                        .removeFromWishList(
                                            context, data.docs[index].id);
                                  },
                                  background: Container(
                                    height: getHeight(context) * 0.1,
                                    width: getWidth(context),
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  key: UniqueKey(),
                                  child: GestureDetector(
                                    onTap: () {

                                      // NAVIGATE TO PRODUCT DETAILS
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
                                );
                              },
                              itemCount: data.docs.length,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.favorite,
                                  size: 50,
                                  color: kBlue,
                                ),
                                Text(
                                  'Wish List is empty',
                                  style: TextStyle(fontFamily: "Regular"),
                                )
                              ],
                            )),
                ),
              ],
            ),
          ),
        );
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
