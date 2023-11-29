import 'dart:convert';


// service model
Services serviceFromJson(String str) => Services.fromJson(json.decode(str));

String serviceToJson(Services data) => json.encode(data.toJson());

class Services {    String? uuid;
    String? slug;
    Detail? name;
    Detail? detail;

    Services({
        this.uuid,
        this.slug,
        this.name,
        this.detail,
    });

   Services copyWith({
        String? uuid,
        String? slug,
        Detail? name,
        Detail? detail,
    }) => 
        Services(
            uuid: uuid ?? this.uuid,
            slug: slug ?? this.slug,
            name: name ?? this.name,
            detail: detail ?? this.detail,
        );

    factory Services.fromJson(Map<String, dynamic> json) => Services(
        uuid: json["uuid"],
        slug: json["slug"],
        name: json["name"] == null ? null : Detail.fromJson(json["name"]),
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "slug": slug,
        "name": name?.toJson(),
        "detail": detail?.toJson(),
    };
}

class Detail {
    String? fr;
    String? en;

    Detail({
        this.fr,
        this.en,
    });

    Detail copyWith({
        String? fr,
        String? en,
    }) => 
        Detail(
            fr: fr ?? this.fr,
            en: en ?? this.en,
        );

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        fr: json["fr"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "fr": fr,
        "en": en,
    };
}
