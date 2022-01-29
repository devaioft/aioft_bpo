// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

Users usersFromJson(dynamic str) => Users.fromJson(str);

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
}

class Fleet {
  Fleet({
    this.id,
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

  int? id;
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
        serviceNumber: json["service_number"],
        serviceModel: json["service_model"],
        address: json["address"],
        addressSecondary: json["address_secondary"],
        city: json["city"],
        country: json["country"],
        documentId: json["document_id"],
        url: json["url"],
        status: json["status"],
        pinCode: json['postal_code'],
      );
}

class Provider {
  Provider({
    this.id,
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

  int? id;
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
        serviceNumber: json["service_number"],
        serviceModel: json["service_model"],
        address: json["address"],
        addressSecondary: json["address_secondary"],
        city: json["city"],
        country: json["country"],
        documentId: json["document_id"],
        url: json["url"],
        status: json["status"],
        pinCode: json['postal_code'],
      );
}
