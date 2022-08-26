import 'package:untitled/features/home/model/product.dart';

class Cart{
  String size;
  int amount;
  Product product;
  Cart({required this.product, required this.size,required this.amount});

  Map<String, dynamic> toMap(){
    return {
      'SIZE' : size,
      'AMOUNT': amount,
      'PRODUCT': product,
    };
  }
  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(product: Product.fromJson(json['PRODUCT']), size: json['SIZE'], amount: json['AMOUNT']);
  }
}