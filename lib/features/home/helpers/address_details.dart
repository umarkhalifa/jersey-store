import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/features/authentication/repositories/auth_provider.dart';

import '../../../contsants/colors.dart';

class AddressDetails extends ConsumerWidget {
  const AddressDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(addressProvider);
    return address.when(
      data: (data) {
        return SizedBox(
          height: getHeight(context) * 0.1,
          width: getWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            //  ADDRESS NAME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",style: TextStyle(fontFamily: "Regular",color: Colors.grey.shade200),),
                  Text("${data.firstName} ${data.lastName}",style: const TextStyle(fontFamily: "Medium",color: Colors.white),)
                ],
              ),

            //  ADDRESS DETAILS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Address",style: TextStyle(fontFamily: "Regular",color: Colors.grey.shade200),),
                  Text(data.deliveryAddress,style: const TextStyle(fontFamily: "Medium",color: Colors.white),)
                ],
              ),

            //  ADDRESS PHONE NUMBER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Phone number",style: TextStyle(fontFamily: "Regular",color: Colors.grey.shade200),),
                  Text(data.phoneNumber,style: const TextStyle(fontFamily: "Medium",color: Colors.white),)
                ],
              )


            ],
          ),
        );
      }, // !ON FETCH ERROR
      error: (e, trace) {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: kBackground,
          child: const Icon(Icons.error),
        );
      },
      //! CART LOADING WIDGET
      loading: () {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: kBackground,
          child: const Center(
            child: SpinKitDancingSquare(
              color: kBlue,
            ),
          ),
        );
      },
    );
  }
}
