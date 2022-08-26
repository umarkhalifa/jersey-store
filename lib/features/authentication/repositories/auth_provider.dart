import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/features/authentication/model/address.dart';
import 'package:untitled/features/authentication/services/authentication.dart';

final authenticationProvider = StateProvider((ref) => Authentication());

final authenticationState = StreamProvider<User?>((ref){
  return ref.read(authenticationProvider).user;
});

final loadingProvider = StateProvider.autoDispose((ref) => false);

// GET USER PHONE_NUMBER
final phoneProvider = FutureProvider((ref) {
  return ref.watch(authenticationProvider).getPhoneNumber();
});

// GET ADDRESS
final addressProvider = FutureProvider<Address>((ref) {
  return ref.watch(authenticationProvider).getAddress();
});