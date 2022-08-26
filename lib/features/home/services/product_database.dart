import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/services/authentication.dart';
import 'package:untitled/features/home/model/cart.dart';
import 'package:untitled/features/home/model/product.dart';
import 'package:uuid/uuid.dart';

class ProductDatabase {
  // FIREBASE FIRESTORE INSTANCE
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // GET POPULAR PRODUCTS
  Future<QuerySnapshot<Map<String, dynamic>>> getLeague(String league) async {
    return firebaseFirestore
        .collection("PRODUCTS")
        .limit(10)
        .where('LEAGUE', isEqualTo: league)
        .get();
  }

  // GET PREMIER LEAGUE PRODUCTS
  Future<QuerySnapshot<Map<String, dynamic>>> getPopular() async {
    return firebaseFirestore.collection("PRODUCTS").limit(10).get();
  }

//  SEARCH PRODUCT
  Future<QuerySnapshot<Map<String, dynamic>>> getSearch() async {
    return firebaseFirestore.collection("PRODUCTS").get();
  }

//  FETCH WISH_LIST
  Stream<QuerySnapshot<Map<String, dynamic>>> getFavorites() async* {
    yield* firebaseFirestore
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("WISH_LIST")
        .snapshots();
  }

//  ADD TO CART
  Future<void> addToCart(Cart cart, BuildContext context) async {
    Uuid uuid = const Uuid();
    bool contains = false;
    final docRef = firebaseFirestore
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CART");
    final dbRef = await firebaseFirestore
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CART")
        .get();
    for(var item in dbRef.docs){
      if(item['PRODUCT']['NAME'] == cart.product.name && item['PRODUCT']['CLUB'] == cart.product.club && item['SIZE'] == cart.size){
        contains = true;
        await item.reference.update({
          'AMOUNT': FieldValue.increment(1)
        });
      }
    }
    if(contains == false){
      await docRef.doc(uuid.v4()).set({
        'SIZE': cart.size,
        'AMOUNT': cart.amount,
        'PRODUCT': cart.product.toMap(),
      });
    }
  }

  Future<bool> checkFavorite(String id) async {
    final favRef = firebaseFirestore
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("WISH_LIST");
    final ref = await favRef.doc(id).get();
    bool exist = ref.exists;
    if (exist == true) {
      return true;
    } else {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartItems() async* {
    yield* firebaseFirestore
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CART")
        .snapshots();
  }

//  GET USER ORDERS
  Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() async* {
    yield* firebaseFirestore
        .collection("USERS")
        .doc(Authentication().current?.uid)
        .collection("ORDERS")
        .snapshots();
  }

// ADD PRODUCT  TO WISH_LIST
  Future<void> addToWish(Product product, String id) async {
    final dbRef = firebaseFirestore
        .collection("USERS")
        .doc(Authentication().current?.uid)
        .collection("WISH_LIST");
    final bool present = await checkFavorite(id);
    if (present == false) {
      await dbRef.doc(id).set({'PRODUCT': product.toMap()});
    } else {
      dbRef.doc(id).delete();
    }
  }

//  REMOVE PRODUCT FROM WISH_LIST
Future<void> removeFromWishList(BuildContext context, String id)async{
    await firebaseFirestore.collection("USERS").doc(Authentication().current?.uid).collection("WISH_LIST").doc(id).delete();
}

// REMOVE PRODUCT FROM CART
Future<void> removeFromCart(BuildContext context, String id)async{
  await firebaseFirestore.collection("USERS").doc(Authentication().current?.uid).collection("CART").doc(id).delete();
}
//INCREMENT CART ITEM
Future<void> incrementCart(String id)async{
    await firebaseFirestore.collection("USERS").doc(Authentication().current?.uid).collection("CART").doc(id).update({
    "AMOUNT": FieldValue.increment(1)
  });
}

//GET PRICE
Stream<int>getPrice()async*{
    int price = 0;
    final dbRef = await firebaseFirestore
        .collection("USERS")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("CART")
        .get();
    for(var element in dbRef.docs){
      price = price + element['AMOUNT'] * 5000 as int;
    }
    yield price;
}
Future<void> clearCart()async{
  final batch = firebaseFirestore.batch();
  var snapShots = await firebaseFirestore.collection("USERS").doc(Authentication().current?.uid).collection("CART").get();
  for(var doc in snapShots.docs){
    batch.delete(doc.reference);
  }
  batch.commit();
}
// ADD ORDER
Future<void> addOrder()async{
    Uuid uuid = const Uuid();
    firebaseFirestore.collection("USERS").doc(Authentication().current?.uid).collection("CART").snapshots().forEach((element) async{
      for(var item in element.docs){
        Cart cart = Cart.fromJson(item.data());
        await firebaseFirestore.collection("USERS").doc(Authentication().current?.uid).collection("ORDERS").doc(uuid.v4()).set({
          "DATE": DateTime.now(),
          "STATUS": false,
          "PRODUCT": cart.product.toMap(),
          "SIZE": cart.size,
          "AMOUNT": cart.amount
        });
      }

    });
    clearCart();
}
}


// PRODUCT DATABASE PROVIDER
final productProvider = Provider((ref) => ProductDatabase());
