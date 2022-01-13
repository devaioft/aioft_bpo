// To parse this JSON data, do
//
//     final providers = providersFromJson(jsonString);

import 'dart:convert';

List<Providers> providersFromJson(String str) => List<Providers>.from(json.decode(str).map((x) => Providers.fromJson(x)));

class Providers {
    Providers({
        this.id,
        this.firstName,
        this.lastName,
        this.mobile,
        this.avatar,
    });

    int? id;
    String? firstName;
    String? lastName;
    String? mobile;
    String? avatar;

    factory Providers.fromJson(Map<String, dynamic> json) => Providers(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        avatar: json["avatar"],
    );
    
}
