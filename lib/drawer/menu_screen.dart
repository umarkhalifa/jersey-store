import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/contsants/colors.dart';
import 'package:untitled/drawer/provider.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticationState);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff010938),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.only(top: 60, left: 20, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 25,
                color: kRed,
              ),
            ),
            const SizedBox(height: 15,),

            //! USER NAME
            Text(
              "${user.value?.displayName}",
              style: const TextStyle(
                  fontFamily: 'Bold',
                  color: Colors.white,
                  fontSize: 16),
            ),

            // !USER EMAIL
            Text(
              "${user.value?.email}",
              style: TextStyle(
                  color: Colors.grey.shade300,
                  fontFamily: 'Regular',
                  fontSize: 12),
            ),

            //! SPACER
            SizedBox(
              height: screenHeight * 0.1,
            ),

            // !1ST MENU ITEM(HOME)
            menuItem(0, () {
              ref.read(index.notifier).state = 0;
            }, "Home", Icons.house_outlined),
            const Spacer(),

            // !2ND MENU ITEM(FAVORITES)
            menuItem(1, () {
              ref.read(index.notifier).state = 1;
            }, "Favorites", Icons.favorite_border_rounded),
            const Spacer(),

            // !3RD MENU ITEM(SHIPPING)
            menuItem(2, () {
              ref.read(index.notifier).state = 2;
            }, "Shipping", Icons.location_pin),
            const Spacer(),

            // !4TH MENU ITEM(ORDER HISTORY)
            menuItem(3, () {
              ref.read(index.notifier).state = 3;
            }, "Order History", Icons.access_time),
            const Spacer(),

            // !5TH MENU ITEM(PROFILE)
            menuItem(4, () {
              ref.read(index.notifier).state = 4;
            }, "Profile", Icons.person_outline_outlined),
            const Spacer(),

            // !SPACERS
            const Spacer(),
            const Spacer(),
            const Spacer(),

            //! LOGOUT ICON
            Row(
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(authenticationProvider).signOut();
                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // MENU ITEM
  Widget menuItem(
      int index, VoidCallback callback, String name, IconData iconData) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.white,
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(

            onTap: callback,
            child: Text(
              name,
              style:
                  const TextStyle(color: Colors.white, fontFamily: "Regular"),
            )),
      ],
    );
  }
}
