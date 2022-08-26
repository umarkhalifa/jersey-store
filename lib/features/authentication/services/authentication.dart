import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/contsants/snack_bar.dart';

import '../model/address.dart';
class Authentication{
  // INSTANTIATE FIREBASE AUTH
  final _auth = FirebaseAuth.instance;

  // GETTER OF USER STREAM
  Stream<User?> get user => _auth.authStateChanges();

  // CURRENT USER
  final current = FirebaseAuth.instance.currentUser;
  // CREATE USER
  Future createUser(String? uid, String phoneNumber)async{
    await FirebaseFirestore.instance.collection("USERS").doc(uid).set({
      "ADDRESS": Address(firstName: " ", lastName: " ", deliveryAddress: " ", phoneNumber: " ").toMap(),
      "PHONE_NUMBER": phoneNumber,
    });
  }

  Future<void>signOut()async{
    await _auth.signOut();
  }

  // LOGIN METHOD
  Future<void> signInWithEmail(String email, String password, BuildContext context)async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);

    }on FirebaseAuthException catch(error){
      if(error.code == "user-not-found"){
        SnackUtils.showSnackBar(myContext: context, message: "User does not exist", isError: true);
      }else if(error.code == "wrong-password"){
        SnackUtils.showSnackBar(myContext: context, message: "Wrong password", isError: true);
      }else{
        SnackUtils.showSnackBar(myContext: context, message: "An error occurred. Please try again", isError: true);
      }
    }
  }

//  SIGN UP METHOD
  Future<void> signUpWithEmail(String name, String email, String password, BuildContext context, String phoneNumber)async{
    try{
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user?.updateDisplayName(name);
      createUser(userCredential.user?.uid, phoneNumber);
    }on FirebaseAuthException catch(error){
      if (error.code == "email-already-exists") {
        SnackUtils.showSnackBar(myContext: context, message: "Email already in use", isError: true);
      } else if (error.code == "invalid-email") {
        SnackUtils.showSnackBar(myContext: context, message: "Invalid email address", isError: true);
      } else {
        SnackUtils.showSnackBar(myContext: context, message: "An error occurred. Please try again", isError: true);
      }
    }
  }

//  RESET PASSWORD
Future<void> resetPassword(String email, BuildContext context)async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e) {
      SnackUtils.showSnackBar(myContext: context, message: "An error occurred. Please try again", isError: true);
    }finally{
      SnackUtils.showSnackBar(myContext: context, message: "Verification email sent.", isError: false);
    }
  }
//  GET USER PHONE NUMBER
Future<String> getPhoneNumber()async{
    final dbRef = await FirebaseFirestore.instance.collection("USERS").doc(current?.uid).get();
    return dbRef.data()!['PHONE_NUMBER'];
}

// GET ADDRESS
Future<Address> getAddress()async{
  final dbRef = await FirebaseFirestore.instance.collection("USERS").doc(current?.uid).get();
  return Address.fromJson(dbRef.data()!['ADDRESS']);

  }
//  UPDATE ADDRESS
Future<void> updateAddress(BuildContext context, Address address)async{
  final dbRef = FirebaseFirestore.instance.collection("USERS").doc(current?.uid);
  await dbRef.update({
    "ADDRESS": address.toMap()
  });
}

// UPDATE USER DETAILS
Future<void> updateDetails(String name, String email, String phoneNumber)async{
  final dbRef = FirebaseFirestore.instance.collection("USERS").doc(current?.uid);
  await current?.updateEmail(email);
  await current?.updateDisplayName(name);
  await dbRef.update({
    "PHONE_NUMBER": phoneNumber
  });
}
Future<void> verifyEmail()async{
await current?.sendEmailVerification();
  }


}