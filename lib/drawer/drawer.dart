import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:untitled/drawer/menu_screen.dart';
import 'package:untitled/drawer/provider.dart';
import 'package:untitled/features/home/presentation/favorite_page.dart';
import 'package:untitled/features/home/presentation/home_page.dart';
import 'package:untitled/features/home/presentation/order_history.dart';
import 'package:untitled/features/home/presentation/profile_page.dart';
import 'package:untitled/features/home/presentation/shipping_page.dart';

class Zoom extends StatelessWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      //! MENU SCREEN
      menuScreen: MenuScreen(),

      // !MAIN SCREEN
      mainScreen: CurrentScreen(),
      angle: 0,
      showShadow: true,
      menuBackgroundColor: Color(0xff010938),
      moveMenuScreen: true,
      mainScreenTapClose: true,
      style: DrawerStyle.defaultStyle,
    );
  }
}

class CurrentScreen extends ConsumerWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // DRAWER INDEX PROVIDER
    final currentIndex = ref.watch(index);

    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const FavoritePage();
      case 2 :
        return const ShippingPage();
      case 3 :
        return  const OrderHistory();
      case 4 :
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
