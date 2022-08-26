
class Product{
  String name;
  String club;
  String league;
  String brand;
  String image;

  Product({required this.name, required this.club, required this.image, required this.league, required this.brand});

  Map<String, dynamic> toMap(){
    return {
      'NAME': name,
      'CLUB': club,
      'LEAGUE': league,
      'BRAND': brand,
      'IMAGE': image
    };
  }
  factory Product.fromJson(Map<String, dynamic> json){
    return Product(name: json['NAME'], club: json['CLUB'], image: json['IMAGE'], league: json['LEAGUE'], brand: json['BRAND']);
  }

}