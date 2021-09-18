import 'dart:convert';

RestaurantList restaurantsFromJson(String str) =>
    RestaurantList.fromJson(json.decode(str));
RestaurantList restaurantFromSearchJson(String str) =>
    RestaurantList.fromJsonSearch(
      json.decode(str),
    );

class RestaurantList {
  bool? error;
  String? message;
  int? founded;
  int? count;
  List<Restaurant>? details;

  RestaurantList({
    this.error,
    this.message,
    this.founded,
    this.count,
    this.details,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      details: List<Restaurant>.from(
        (json["restaurants"] as List).map(
          (e) => Restaurant.fromJson(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(details!.map((x) => x.toJson())),
      };

  factory RestaurantList.fromJsonSearch(Map<String, dynamic> json) {
    return RestaurantList(
      error: json["error"],
      founded: json["founded"],
      count: json["count"],
      details: List<Restaurant>.from(
        json["restaurants"].map(
          (e) => Restaurant.fromJson(e),
        ),
      ),
    );
  }
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
