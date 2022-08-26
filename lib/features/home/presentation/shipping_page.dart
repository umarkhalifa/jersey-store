import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';

import '../../../contsants/colors.dart';
import '../../authentication/model/address.dart';
import '../helpers/cart_icon.dart';

class ShippingPage extends ConsumerStatefulWidget {
  const ShippingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends ConsumerState<ShippingPage> {
  final _formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String deliveryAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.refresh(addressProvider);
  }

  @override
  Widget build(BuildContext context) {
    // ADDRESS PROVIDER REF
    final address = ref.watch(addressProvider);

    return address.when(
      data: (data) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              height: getHeight(context),
              width: getWidth(context),
              decoration: BoxDecoration(
                gradient: kGradient
              ),
              child: Column(
                children: [
                  // TOP BAR
                  Row(
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
                       Text(
                        "Shipping Details",
                        style: kHead,
                      ),
                      const CartIcon(),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FIRST NAME FORM
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "First Name",
                              style: TextStyle(fontFamily: "Regular",color: Colors.white),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Enter a valid Name";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                firstName = value;
                              },
                              initialValue: address.value!.firstName,
                              style: const TextStyle(
                                fontFamily: 'Regular',color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person,color: Colors.white,),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),

                        // LAST NAME FORM
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Last Name",
                              style: TextStyle(fontFamily: "Regular",color: Colors.white),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Enter a valid Name";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                lastName = value;
                              },
                              initialValue: address.value!.lastName,
                              style: const TextStyle(fontFamily: 'Regular',color: Colors.white),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person,color: Colors.white,),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),

                        // PHONE NUMBER FORM
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Phone Number",
                              style: TextStyle(fontFamily: "Regular",color: Colors.white),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.length < 7) {
                                  return "Enter a valid phone number";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                phoneNumber = value;
                              },
                              initialValue: address.value!.phoneNumber,
                              style: const TextStyle(fontFamily: 'Regular',color: Colors.white),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone,color: Colors.white,),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),

                        //ADDRESS INFO FORM
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Delivery Address",
                              style: TextStyle(fontFamily: "Regular",color: Colors.white),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value != null && value.length < 7) {
                                  return "Enter a valid address";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                deliveryAddress = value;
                              },
                              initialValue: address.value!.deliveryAddress,
                              style: const TextStyle(fontFamily: 'Regular',color: Colors.white),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_pin,color: Colors.white,),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        // EDIT DETAILS BUTTON
                        GestureDetector(
                          onTap: () async {
                            if (firstName.isEmpty) {
                              firstName = data.firstName;
                            } if (lastName.isEmpty) {
                              lastName = data.lastName;
                            }  if (phoneNumber.isEmpty) {
                              phoneNumber = data.phoneNumber;
                            }  if (deliveryAddress.isEmpty) {
                              deliveryAddress = data.deliveryAddress;
                            }
                            if (_formKey.currentState!.validate()) {
                              try {

                                await ref
                                    .read(authenticationProvider)
                                    .updateAddress(
                                        context,
                                        Address(
                                            firstName: firstName,
                                            lastName: lastName,
                                            deliveryAddress: deliveryAddress,
                                            phoneNumber: phoneNumber));
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Details updated successfully."),backgroundColor: Colors.green,),);
                                }
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occurred"),backgroundColor: Colors.red,),);

                              }
                            }
                          },
                          child: Container(
                            height: getHeight(context) * 0.07,
                            width: getWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                "Update Details",
                                style: TextStyle(
                                    fontFamily: "Medium",
                                    color: kBlue),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
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
      //LOADING
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          decoration: BoxDecoration(
              gradient: kGradient
          ),
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
