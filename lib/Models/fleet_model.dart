// To parse this JSON data, do
//
//     final fleetUser = fleetUserFromJson(jsonString);

import 'dart:convert';

List<FleetUser> fleetUserFromJson(String str) => List<FleetUser>.from(json.decode(str).map((x) => FleetUser.fromJson(x)));

String fleetUserToJson(List<FleetUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FleetUser {
    FleetUser({
        this.id,
        this.name,
        this.mobile,
    });

    int? id;
    String? name;
    String? mobile;

    factory FleetUser.fromJson(Map<String, dynamic> json) => FleetUser(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
    };
}
