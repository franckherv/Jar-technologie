// To parse this JSON data, do
//
//     final packs = packsFromJson(jsonString);

import 'dart:convert';

Packs packsFromJson(String str) => Packs.fromJson(json.decode(str));

String packsToJson(Packs data) => json.encode(data.toJson());

class Packs {
    var uuid;
    String? name;
    final price;
    String? currency;
    String? priceUnit;
    int? priceDuration;
    int? diskQuota;
    int? userQuota;
    String? detail;
    String? photo;

    Packs({
        this.uuid,
        this.name,
        this.price,
        this.currency,
        this.priceUnit,
        this.priceDuration,
        this.diskQuota,
        this.userQuota,
        this.detail,
        this.photo,
    });

    Packs copyWith({
        String? uuid,
        String? name,
        int? price,
        String? currency,
        String? priceUnit,
        int? priceDuration,
        int? diskQuota,
        int? userQuota,
        String? detail,
        String? photo,
    }) => 
        Packs(
            uuid: uuid ?? this.uuid,
            name: name ?? this.name,
            price: price ?? this.price,
            currency: currency ?? this.currency,
            priceUnit: priceUnit ?? this.priceUnit,
            priceDuration: priceDuration ?? this.priceDuration,
            diskQuota: diskQuota ?? this.diskQuota,
            userQuota: userQuota ?? this.userQuota,
            detail: detail ?? this.detail,
            photo: photo ?? this.photo,
        );

    factory Packs.fromJson(Map<String, dynamic> json) => Packs(
        uuid: json["uuid"],
        name: json["name"],
        price: json["price"],
        currency: json["currency"].toString(),
        priceUnit: json["price_unit"],
        priceDuration: json["price_duration"],
        diskQuota: json["disk_quota"],
        userQuota: json["user_quota"],
        detail: json["detail"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "price": price,
        "currency": currency,
        "price_unit": priceUnit,
        "price_duration": priceDuration,
        "disk_quota": diskQuota,
        "user_quota": userQuota,
        "detail": detail,
        "photo": photo,
    };
}
