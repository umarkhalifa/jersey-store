class Address{
  String firstName;
  String lastName;
  String deliveryAddress;
  String? additionalInfo;
  String phoneNumber;
  String? additionalNumber;
  Address({required this.firstName, required this.lastName, required this.deliveryAddress, this.additionalInfo, required this.phoneNumber, this.additionalNumber});

  Map<String, dynamic> toMap(){
    return {
      'FIRST_NAME': firstName,
      'LAST_NAME': lastName,
      'DELIVERY_ADDRESS': deliveryAddress,
      'ADDITIONAL_INFO': additionalInfo,
      'PHONE_NUMBER': phoneNumber,
      'ADDITIONAL_NUMBER': additionalNumber,
    };
  }
  factory Address.fromJson(Map<String, dynamic>? json){
    return Address(
        firstName: json!['FIRST_NAME'],
        lastName: json['LAST_NAME'],
        deliveryAddress: json['DELIVERY_ADDRESS'],
        additionalInfo: json['ADDITIONAL_INFO'],
        phoneNumber: json['PHONE_NUMBER'],
        additionalNumber: json['ADDITIONAL_NUMBER']
    );

  }
}