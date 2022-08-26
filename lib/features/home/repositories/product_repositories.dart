import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/home/repositories/providers.dart';
import 'package:untitled/features/home/services/product_database.dart';

import '../model/league.dart';

// POPULAR PRODUCT FUTURE PROVIDER
final popularProductProvider = FutureProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return ref.watch(productProvider).getLeague(leagues[ref.watch(leagueIndexProvider)].name);
});

// PREMIER LEAGUE PRODUCT FUTURE PROVIDER
final premierProductProvider = FutureProvider.autoDispose<QuerySnapshot<Map<String,dynamic>>>((ref)  {
  return ref.watch(productProvider).getPopular();
});

// SEARCH PRODUCTS
final searchProvider = FutureProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return ref.watch(productProvider).getSearch();
});

// CART STREAM
final cartStream = StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return ref.watch(productProvider).cartItems();
});

// CHECK FAVORITE
final checkFavoriteProvider = FutureProvider.family.autoDispose((ref, String id){
  return ref.watch(productProvider).checkFavorite(id);
});

// FETCH WISHLIST
final favoriteProvider = StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return ref.watch(productProvider).getFavorites();
});

// FETCH ORDERS
final orderProvider = StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  return ref.watch(productProvider).getOrders();
});

// FETCH PRICE
final priceProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(productProvider).getPrice();
});



// ADD ORDER
final addOrder = StateProvider.autoDispose((ref){
  return ref.read(productProvider).addOrder();
});
// ADD TO WISH_LIST
