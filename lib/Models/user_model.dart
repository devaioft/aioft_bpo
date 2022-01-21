// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

// String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    Users({
        this.providers,
        this.fleet,
        this.code,
    });

    List<Provider>? providers;
    List<Fleet>? fleet;
    int? code;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        providers: List<Provider>.from(json["providers"].map((x) => Provider.fromJson(x))),
        fleet: List<Fleet>.from(json["fleet"].map((x) => Fleet.fromJson(x))),
        code: json["code"],
    );

    // Map<String, dynamic> toJson() => {
    //     "providers": List<dynamic>.from(providers!.map((x) => x.toJson())),
    //     "fleet": List<dynamic>.from(fleet!.map((x) => x.toJson())),
    //     "code": code,
    // };
}

class Fleet {
    Fleet({
        this.id,
        this.name,
        this.mobile,
    });

    int? id;
    String? name;
    String? mobile;

    factory Fleet.fromJson(Map<String, dynamic> json) => Fleet(
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

class Provider {
    Provider({
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

    factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "avatar": avatar,
    };
}
