import 'package:flutter/material.dart';
import 'package:untitled/features/home/presentation/search_products.dart';

import '../../../contsants/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String val = "";
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: getHeight(context) * 0.06,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff2058b7).withOpacity(0.5),

              //! SHADOW EFFECT
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff2058b7).withOpacity(0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 3),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: TextFormField(
                onChanged: (value){
                  val = value;
                },
                onFieldSubmitted: (value) {
                  //! PUSH QUERY TO SEARCH PAGE
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(query: value),
                    ),
                  );
                },
                style: const TextStyle(fontFamily: "Regular", fontSize: 14,color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 19,
                    color: Colors.white,
                  ),
                  hintText: "Search Products",
                  hintStyle: TextStyle(
                      fontFamily: "Regular", fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(query: val),
                ),
              );
            },
            child: Container(
              height: getHeight(context) * 0.06,
              margin: const EdgeInsets.only(right: 20,left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff2058b7),

                //! SHADOW EFFECT
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff2058b7).withOpacity(0.1),
                      offset: const Offset(0, 3),
                      blurRadius: 3),
                ],
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
