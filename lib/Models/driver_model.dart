// To parse this JSON data, do
//     final drivers = driversFromJson(jsonString);

import 'dart:convert';

List<Drivers> driversFromJson(String str) =>
    List<Drivers>.from(json.decode(str).map((x) => Drivers.fromJson(x)));

String driversToJson(List<Drivers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Drivers {
  Drivers({
    this.id,
    this.carType,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.cityName,
  });

  int? id;
  String? carType;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? cityName;

  factory Drivers.fromJson(Map<String, dynamic> json) => Drivers(
        id: json["id"],
        carType: json["car_type"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_type": carType,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "city_name": cityName,
      };
}
