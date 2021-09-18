import 'dart:convert';

import 'package:babe_resto/data/models/category.dart';
import 'package:babe_resto/data/models/review.dart';

RestaurantDetail restaurantFromJson(String str) =>
    RestaurantDetail.fromJson(json.decode(str));

class RestaurantDetail {
  bool? error;
  String? message;
  RestaurantDetailItem? detail;

  RestaurantDetail({this.error, this.message, this.detail});

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      error: json["error"],
      message: json["message"],
      detail: RestaurantDetailItem.fromJsonDetail(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": detail!.toJson(),
      };
}

class RestaurantDetailItem {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  RestaurantDetailItem({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory RestaurantDetailItem.fromJsonDetail(Map<String, dynamic> json) {
    return RestaurantDetailItem(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: List<Category>.from(
        json["categories"].map(
          (e) => Category.fromJson(e),
        ),
      ),
      menus: Menus.fromJson(json["menus"]),
      rating: json["rating"].toDouble(),
      customerReviews: List<CustomerReview>.from(
        json["customerReviews"].map(
          (e) => CustomerReview.fromJson(e),
        ),
      ),
    );
  }

  factory RestaurantDetailItem.fromJsonItem(Map<String, dynamic> json) {
    return RestaurantDetailItem(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      rating: json["rating"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus!.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
