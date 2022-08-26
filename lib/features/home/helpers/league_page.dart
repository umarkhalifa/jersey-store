import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/features/home/helpers/bottom_sheet.dart';
import 'package:untitled/features/home/helpers/league_card.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:untitled/features/home/presentation/product_page.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';

import '../repositories/providers.dart';

class LeaguePage extends ConsumerWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! SCREEN HEIGHT
    final screenHeight = MediaQuery.of(context).size.height;

    //! SCREEN WIDTH
    final screenWidth = MediaQuery.of(context).size.width;

    //! LEAGUE PAGE CURRENT PAGE
    final position = ref.watch(currentPage);

    //! LEAGUE PAGE PROVIDER
    final asyncValue = ref.watch(popularProductProvider);

    return asyncValue.when(data: (data) {
      return SizedBox(
        height: screenHeight * 0.45,
        width: screenWidth,
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            //! PRODUCT MODEL INSTANCE
            Product product = Product.fromJson(data.docs[index].data());
            return ShowUpAnimation(
              direction: Direction.horizontal,
              child: AnimatedScale(
                curve: Curves.easeOut,
                scale: position == index ? 1 : 0.8,
                duration: duration,
                child: AnimatedOpacity(
                  opacity: position == index ? 1 : 0.8,
                  duration: duration,
                  child: Container(
                    height: screenHeight * 0.42,
                    width: getWidth(context),
                    decoration: BoxDecoration(
                        color: kBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PRODUCT IMAGE
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: ProductPage(
                                      product: product,
                                      id: data.docs[index].id),
                                  type: PageTransitionType.fade),
                            );
                          },
                          child: Container(
                            height: getHeight(context) * 0.3,
                            width: getWidth(context),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10)),
                            child: LeagueCard(
                                image: product.image,
                                club: product.club,
                                height: getHeight(context) * 0.27,
                                width: getWidth(context),
                                check: position == index),
                          ),
                        ),

                        // SPACER
                        const SizedBox(
                          height: 12,
                        ),

                        //  PRODUCT CLUB
                        Text(
                          product.club.toUpperCase(),
                          style: const TextStyle(
                              fontFamily: "Medium",
                              color: Colors.white,
                              fontSize: 17),
                        ),

                        //  PRODUCT TYPE
                        Text(
                          product.name,
                          style: TextStyle(
                              fontFamily: "Regular",
                              color: Colors.grey.shade300,
                              fontSize: 13),
                        ),

                        //SPACER
                        const Spacer(),

                        //  PRICE AND ADD BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "NGN 5000",
                              style: kHead,
                            ),
                            GestureDetector(
                              onTap: (){
                                showBottom(data.docs[index].id, product, context, ref);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  color: kBlue,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: data.docs.length,
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: (index) {
            ref.read(currentPage.notifier).state = index;
          },
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
            child: SpinKitFadingCircle(
                color: Colors.white
            ),
          ),
        );
      },);
  }
}
