import 'package:prishathe/Model/Usermodel.dart';
class AddressModel {
  String id;
  final String userId;
  final String billingFirstName;
  final String billingLastName;
  final String billingAddress1;
  final String? billingAddress2;
  final String billingCity;
  final String billingState;
  final String billingCountry;
  final String billingPostcode;
  final String billingPhone;

  AddressModel({
    this.id = "",
    required this.userId,
    required this.billingFirstName,
    required this.billingLastName,
    required this.billingAddress1,
    this.billingAddress2,
    required this.billingCity,
    required this.billingState,
    required this.billingCountry,
    required this.billingPostcode,
    required this.billingPhone,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'billing_first_name': billingFirstName,
      'billing_last_name': billingLastName,
      'billing_address_1': billingAddress1,
      'billing_address_2': billingAddress2 ?? '',
      'billing_city': billingCity,
      'billing_state': billingState,
      'billing_country': billingCountry,
      'billing_postcode': billingPostcode,
      'billing_phone': billingPhone,
    };
  }

  static AddressModel empty() => AddressModel(
        userId: " ",
        billingFirstName: " ",
        billingLastName: " ",
        billingAddress1: " ",
        billingCity: " ",
        billingState: " ",
        billingCountry: " ",
        billingPostcode: " ",
        billingPhone: " ",
        id: "",
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      userId: json['user_id'].toString(),
      billingFirstName: json['billing_first_name'],
      billingLastName: json['billing_last_name'],
      billingAddress1: json['billing_address_1'],
      billingAddress2: json['billing_address_2'] ?? '',
      billingCity: json['billing_city'],
      billingState: json['billing_state'],
      billingCountry: json['billing_country'],
      billingPostcode: json['billing_postcode'],
      billingPhone: json['billing_phone'],
      id: json['id'].toString(),
    );
  }

  String get formattedPhoneNo => formatter.formatPhoneNumber(billingPhone);

  /*factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      name: data['Name'] as String,
      id: data['Id'] as String,
      state: data['State'] as String,
      street: data['Street'] as String,
      phoneNumber: data['Phone Number'] as String,
      postalCode: data['Postal Code'] as String,
      country: data['Country'] as String,
      city: data['City'] as String,
      selectedAddress: data['Selected Address'] as bool,
      dateTime: (data['Date Time'] as Timestamp).toDate(),
    );
  }*/

  /*factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      name: data['Name'] ?? '',
      id: snapshot.id,
      state: data['State'] ?? '',
      street: data['Street'] ?? '',
      phoneNumber: data['Phone Number'] ?? '',
      postalCode: data['Postal Code'] ?? '',
      country: data['Country'] ?? '',
      city: data['City'] ?? '',
      selectedAddress: data['Selected Address'] as bool,
      dateTime: (data['Date Time'] as Timestamp).toDate(),
    );
  }*/

  @override
  String toString() {
    return '$billingAddress1 $billingAddress2,$billingCity,$billingState,$billingPostcode,$billingCountry';
  }
}
