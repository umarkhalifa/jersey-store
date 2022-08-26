import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';
import 'package:untitled/features/authentication/services/authentication.dart';

import '../../../contsants/colors.dart';
import '../helpers/cart_icon.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? name = "";
  String? email = "";
  String phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.refresh(phoneProvider);
  }

  @override
  Widget build(BuildContext context) {
    // PHONE PROVIDER REF
    final phoneRef = ref.watch(phoneProvider);

    return phoneRef.when(data: (data) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          height: getHeight(context),
          width: getWidth(context),
          decoration: BoxDecoration(gradient: kGradient),
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
                  const Text(
                    "Profile",
                    style: TextStyle(fontFamily: 'Medium', color: Colors.white),
                  ),
                  const CartIcon(),
                ],
              ),

              //SPACER
              const SizedBox(
                height: 25,
              ),

              // ! FORMS
              Expanded(
                  child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //NAME FORM
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                              fontFamily: "Regular", color: Colors.white),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Enter a valid Name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                          initialValue:
                              "${Authentication().current?.displayName}",
                          style: const TextStyle(
                              fontFamily: 'Regular,', color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),

                    //EMAIL FORM
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontFamily: "Regular", color: Colors.white),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.length < 7) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          initialValue: "${Authentication().current?.email}",
                          style: const TextStyle(
                              fontFamily: 'Regular', color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                          style: TextStyle(
                              fontFamily: "Regular", color: Colors.white),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.length < 10) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          initialValue: data,
                          style: const TextStyle(
                              fontFamily: 'Regular', color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),

                    // EDIT PROFILE BUTTON
                    GestureDetector(
                      onTap: () async {
                        if (name != null && name!.isEmpty) {
                          name = Authentication().current?.displayName;
                        }
                        if (email != null && email!.isEmpty) {
                          email = Authentication().current?.email;
                        }
                        if (phoneNumber.isEmpty) {
                          phoneNumber = data;
                        }
                        if (_formKey.currentState!.validate()) {
                          try {
                            await ref
                                .read(authenticationProvider)
                                .updateDetails(name!, email!, phoneNumber);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Details updated successfully"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("An error occurred"),
                                backgroundColor: Colors.red,
                              ),
                            );
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
                            "Update Profile",
                            style:
                                TextStyle(fontFamily: "Medium", color: kBlue),
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

      //WHEN ITEMS LOADING
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          decoration: BoxDecoration(
              gradient: kGradient
          ),
          child: const Center(
            child: SpinKitFadingCircle(
                color: Colors.white
            ),
          ),
        );
      },);
  }
}
