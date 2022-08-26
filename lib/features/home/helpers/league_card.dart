import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LeagueCard extends StatelessWidget {
  final String image;
  final String club;
  final double height;
  final double width;
  final bool check;

  const LeagueCard(
      {Key? key,
      required this.image,
      required this.club,
      required this.height,
      required this.width,
      required this.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [

          //! SHADOW IMAGE
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 30,
              width: 150,
              child: Image.asset(
                "assets/images/shadow3.png",
                fit: BoxFit.fill,
              ),
            ),
          ),

          //! PRODUCT IMAGE
          Positioned(
            bottom: 30,
            child: SizedBox(
              height: height ,
              width: width,
              child: Image.network(
                image,
                fit: BoxFit.contain,

                //! IMAGE LOADING WIDGET
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                    ),
                  );
                },

                //! IMAGE FETCH ERROR
                errorBuilder: (context, object, trace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
