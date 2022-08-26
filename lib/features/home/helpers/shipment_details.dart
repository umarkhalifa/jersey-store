import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/features/home/repositories/product_repositories.dart';

import '../../../contsants/colors.dart';

class ShipmentDetails extends ConsumerWidget {
  const ShipmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(cartStream);
    return details.when(
      data: (data) {
        return Column(
            children: data.docs.map((items) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //DIVIDER
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              //
              // PRODUCT NUMBER AND CLUB
              Text(
                "${items['AMOUNT']} x   ${items['PRODUCT']['CLUB']}",
                style: const TextStyle(fontFamily: "Medium", color: Colors.white),
              ),
              //  SPACER
              const SizedBox(
                height: 10,
              ),
              //  PRODUCT SIZE
              Text(
                "Size:${items['SIZE']}",
                style: TextStyle(
                    fontFamily: "Regular", color: Colors.grey.shade50),
              ),
              // SPACER
              const SizedBox(
                height: 10,
              ),

              //  DELIVERY TIME
              Text(
                "Delivered in 3 to 5 days(Abuja)",
                style: TextStyle(
                    fontFamily: "Regular", color: Colors.grey.shade50),
              ),
              // SPACER
              const SizedBox(
                height: 10,
              ),
              //DIVIDER
              const Divider(),
            ],
          );
        }).toList());
      },
      // ON ITEMS FETCH ERROR
      error: (e, trace) {
        return Container(
          height: getHeight(context),
          width: getWidth(context),
          color: kBackground,
          child: const Icon(Icons.error),
        );
      },

      //WHEN ITEMS LOADING
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
