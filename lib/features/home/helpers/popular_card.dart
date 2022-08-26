import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/contsants/colors.dart';

class PopularCard extends StatelessWidget {
  final Function callback;
  final String id;
  final String club;
  final String image;
  final String name;

  const PopularCard(
      {Key? key,
        required this.callback,
      required this.id,
      required this.club,
      required this.image,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! SCREEN HEIGHT
    final screenHeight = MediaQuery.of(context).size.height;

    //! SCREEN WIDTH
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: screenHeight * 0.14,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // !POPULAR CARD CONTAINER DECORATOR
            Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.2, top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    color: kBlue.withOpacity(0.65),

                    //! SHADOW EFFECT
                    boxShadow: [
                      BoxShadow(
                          color: kBlue.withOpacity(0.1),
                          offset: const Offset(0, 5),
                          blurRadius: 7),
                    ],

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! PRODUCT CLUB NAME
                          Text(
                            club.toUpperCase(),
                            style: const TextStyle(
                                fontFamily: "Medium", color: Colors.white),
                          ),

                          //! PRODUCT CLUB TYPE
                          Text(
                            name,
                            style:  TextStyle(
                                fontFamily: "Regular",
                                color: Colors.grey.shade200,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          callback();
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,

                            //! SHADOW EFFECT
                            boxShadow: [
                              BoxShadow(
                                color: kBlue.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 19,
                            color: kBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //! PRODUCT IMAGE
            Positioned(
              top: 0,
              child: SizedBox(
                height: screenHeight * 0.11,
                width: screenWidth * 0.3,
                child: Image.network(
                  image,

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

            //! SHADOW IMAGE
            Positioned(
              left: 25,
              bottom: 5,
              child: SizedBox(
                width: 70,
                height: 30,
                child: Image.asset("assets/images/shadow.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
