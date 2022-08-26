
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/features/home/helpers/popular_card.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/presentation/product_page.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';

import 'bottom_sheet.dart';

class PopularProductList extends ConsumerStatefulWidget {
  const PopularProductList({Key? key}) : super(key: key);

  @override
  ConsumerState<PopularProductList> createState() => _PopularProductListState();
}

class _PopularProductListState extends ConsumerState<PopularProductList> {
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(premierProductProvider);
    return value.when(
      data: (data) {
        return ShowUpAnimation(
          direction: Direction.horizontal,
          animationDuration: const Duration(milliseconds: 500),
          child: Column(
            children: data.docs
                .map((product) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                                product: Product.fromJson(product.data()),
                                id: product.id),
                          ),
                        );
                      },
                      child: PopularCard(
                          callback: () {
                            showBottom(
                                product.id, Product.fromJson(product.data()), context,ref);
                          },
                          id: product.id,
                          club: product['CLUB'],
                          image: product['IMAGE'],
                          name: product['NAME']),
                    ))
                .toList(),
          ),
        );
      },
      // ON ITEMS FETCH ERROR
      error: (e, trace) {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: Colors.transparent,
          child: const Icon(Icons.error),
        );
      },

      //WHEN ITEMS LOADING
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: Colors.transparent,
          child: const Center(
            child: SpinKitDancingSquare(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
