// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(dynamic str) => Users.fromJson(str);

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.providers,
    this.fleet,
  });

  List<Provider>? providers;
  List<Fleet>? fleet;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        providers: List<Provider>.from(
            json["providers"].map((x) => Provider.fromJson(x))),
        fleet: List<Fleet>.from(json["fleet"].map((x) => Fleet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "providers": List<dynamic>.from(providers!.map((x) => x.toJson())),
        "fleet": List<dynamic>.from(fleet!.map((x) => x.toJson())),
      };
}

class Fleet {
  Fleet({
    this.name,
    this.email,
    this.mobile,
    this.logo,
    this.firstName,
    this.lastName,
    this.avatar,
    this.serviceNumber,
    this.serviceModel,
    this.address,
    this.addressSecondary,
    this.city,
    this.country,
    this.documentId,
    this.url,
    this.status,
    this.pinCode,
  });

  dynamic name;
  String? email;
  String? mobile;
  dynamic logo;
  String? firstName;
  String? lastName;
  String? avatar;
  String? serviceNumber;
  String? serviceModel;
  String? address;
  String? addressSecondary;
  String? city;
  String? country;
  String? documentId;
  String? url;
  String? status;
  String? pinCode;

  factory Fleet.fromJson(Map<String, dynamic> json) => Fleet(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        logo: json["logo"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        serviceNumber:
            json["service_number"],
        serviceModel:
            json["service_model"],
        address: json["address"],
        addressSecondary: json["address_secondary"],
        city: json["city"],
        country: json["country"],
        documentId: json["document_id"],
        url: json["url"],
        status: json["status"],
        pinCode: json['postal_code'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "logo": logo,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "service_number": serviceNumber,
        "service_model": serviceModel,
        "address": address,
        "address_secondary": addressSecondary,
        "city": city,
        "country": country,
        "document_id": documentId ,
        "url": url,
        "status": status,
      };
}

class Provider {
  Provider({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.avatar,
    this.serviceNumber,
    this.serviceModel,
    this.address,
    this.addressSecondary,
    this.city,
    this.country,
    this.documentId,
    this.url,
    this.status,
    this.pinCode,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? avatar;
  String? serviceNumber;
  String? serviceModel;
  String? address;
  String? addressSecondary;
  String? city;
  String? country;
  String? documentId;
  String? url;
  String? status;
  String? pinCode;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        serviceNumber:
            json["service_number"],
        serviceModel:
            json["service_model"],
        address: json["address"],
        addressSecondary: json["address_secondary"],
        city: json["city"],
        country: json["country"],
        documentId: json["document_id"],
        url: json["url"],
        status: json["status"],
        pinCode: json['postal_code'],

      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "avatar": avatar,
        "service_number": serviceNumber,
        "service_model": serviceModel,
        "address": address,
        "address_secondary": addressSecondary,
        "city": city,
        "country": country,
        "document_id": documentId,
        "url": url,
        "status": status,
      };
}
