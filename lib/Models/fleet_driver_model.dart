// To parse this JSON data, do
//
//     final fleetDrivers = fleetDriversFromJson(jsonString);

import 'dart:convert';

FleetDrivers fleetDriversFromJson(String str) => FleetDrivers.fromJson(json.decode(str));


class FleetDrivers {
    FleetDrivers({
        this.fleet,
    });

    List<FleetDriver>? fleet;

    factory FleetDrivers.fromJson(Map<String, dynamic> json) => FleetDrivers(
        fleet: List<FleetDriver>.from(json["fleet"].map((x) => FleetDriver.fromJson(x))),
    );
 
}

class FleetDriver {
    FleetDriver({
        this.fid,
        this.fname,
        this.femail,
        this.fmobile,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.avatar,
        this.fleet,
        this.status,
        this.serviceNumber,
        this.serviceModel,
        this.address,
        this.addressSecondary,
        this.city,
        this.country,
        this.postalCode,
        this.documentId,
        this.url,
    });

    int? fid;
    String? fname;
    String? femail;
    String? fmobile;
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? mobile;
    String? avatar;
    int? fleet;
    dynamic status;
    String? serviceNumber;
    String ?serviceModel;
    String ?address;
    String ?addressSecondary;
    String ?city;
    String? country;
    String? postalCode;
    dynamic documentId;
    dynamic url;

    factory FleetDriver.fromJson(Map<String, dynamic> json) => FleetDriver(
        fid: json["fid"],
        fname: json["fname"],
        femail: json["femail"],
        fmobile: json["fmobile"],
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        fleet: json["fleet"],
        status: json["status"],
        serviceNumber: json["service_number"],
        serviceModel: json["service_model"],
        address: json["address"],
        addressSecondary: json["address_secondary"],
        city: json["city"],
        country: json["country"],
        postalCode: json["postal_code"],
        documentId: json["document_id"],
        url: json["url"],
    );

  
}
