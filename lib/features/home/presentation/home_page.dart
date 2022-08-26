import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/features/home/helpers/cart_icon.dart';
import 'package:untitled/features/home/helpers/league_page.dart';
import 'package:untitled/features/home/helpers/populat_list.dart';

import '../helpers/leagues_list.dart';
import '../helpers/search_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff184694),
          Color(0xff010938),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //! TOP BAR
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: ShowUpAnimation(
                direction: Direction.horizontal,
                child: Row(
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
                    const CartIcon()
                  ],
                ),
              ),
            ),

            // !SPACER
            const SizedBox(
              height: 15,
            ),

            //! DISCOVER ITEMS TEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Support your team",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Regular",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "In style",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Regular",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // !SPACER
            const SizedBox(
              height: 10,
            ),

            //! SEARCH BAR
            ShowUpAnimation(
                direction: Direction.horizontal, child: const SearchBar()),

            // !SPACER
            const SizedBox(
              height: 15,
            ),

            //!LEAGUES LIST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: getHeight(context) * 0.1,
                width: getWidth(context),
                child: const LeaguesList(),
              ),
            ),

            // !LEAGUE PAGE
            const LeaguePage(),

            //! POPULAR TEXT
            ShowUpAnimation(
              direction: Direction.horizontal,
              child: const Padding(
                padding: EdgeInsets.only(top: 30, right: 20, left: 20),
                child: Text(
                  "Popular Products",
                  style: TextStyle(
                    fontFamily: "Medium",
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // POPULAR PRODUCT LIST
            const PopularProductList()
          ],
        ),
      ),
    );
  }
}
