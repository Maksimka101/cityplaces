import 'dart:convert';

import 'package:cityplaces/src/models/place_type_model.dart';

class PlaceInfo {
  PlaceInfo({
    this.spentTimeMin,
    this.imagesUrl = const <String>[
      "http://otzivy.info/_pu/6/28673987.jpg"
    ],
    this.tags,
    this.userRating,
    this.description,
    this.name,
    this.placeId,
    this.long,
    this.lat,
    this.adress,
    this.opensAt,
    this.systemRating,
    this.id,
    this.favorite,
    this.averagePrice,
    this.closesAt,
    this.existUntil,
    this.createdAt,
  });

  final String name;
  final String adress;
  final int closesAt;
  final int opensAt;
  final String existUntil;
  final int systemRating;
  final int averagePrice;
  final bool favorite;
  final String id;
  final List<String> imagesUrl;
  final String description;
  final int userRating;
  final double lat;
  final double long;
  final String placeId;
  final List<PlaceType> tags;
  final int spentTimeMin;
  final String createdAt;

  static PlaceInfo fromMap(Map<dynamic, dynamic> json) => PlaceInfo(
        adress: json["address"],
        averagePrice: json["averagePrice"],
        spentTimeMin: json["averageTimeSpentMin"],
        closesAt: json["closesAt"],
        createdAt: json["createdAt"],
        description: json["description"],
        existUntil: json["existsUntil"],
        imagesUrl: [json["imageUrl"]],
        favorite: json["favorite"],
        id: json["id"],
        lat: json["latitude"],
        long: json["longitude"],
        name: json["name"],
        opensAt: json["opensAt"],
        systemRating: json["systemRating"],
        tags: typesFromDynamic(json["tags"]),
        userRating: json["userRating"],
      );

  static List<PlaceType> typesFromDynamic(List<dynamic> types) {
    final _types = <PlaceType>[];
    if (types != null)
      for (final type in types) {
        // todo
        _types.add(Unknown());
      }
    else
      _types.add(Unknown());
    return _types;
  }

  static PlaceInfo fromJson(String json) {
    final _json = jsonDecode(json);
    return PlaceInfo(
      adress: _json["address"],
      averagePrice: _json["averagePrice"],
      spentTimeMin: _json["averageTimeSpentMin"],
      closesAt: _json["closesAt"],
      createdAt: _json["createdAt"],
      description: _json["description"],
      existUntil: _json["existsUntil"],
      favorite: _json["favorite"],
      imagesUrl: _json["imageUrl"],
      id: _json["id"],
      lat: _json["latitude"],
      long: _json["longitude"],
      name: _json["name"],
      opensAt: _json["opensAt"],
      systemRating: _json["systemRating"],
      tags: typesFromDynamic(_json["tags"]),
      userRating: _json["userRating"],
    );
  }

  String get toJson {
    final json = <String, dynamic>{};
    json["address"] = adress;
    json["averagePrice"] = averagePrice;
    json["averageTimeSpentMin"] = spentTimeMin;
    json["closesAt"] = closesAt;
    json["createdAt"] = createdAt;
    json["description"] = description;
    json["existUntil"] = existUntil;
    json["favorite"] = favorite;
    json["imageUrl"] = imagesUrl;
    json['id'] = id;
    json["latitude"] = lat;
    json["longitude"] = long;
    json["name"] = name;
    json["opensAt"] = opensAt;
    json["systemRating"] = systemRating;
    json["userRating"] = userRating;
    return jsonEncode(json);
  }
}
