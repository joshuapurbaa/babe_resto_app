import 'dart:convert';

String reviewToJson(CustomerReview review) => json.encode(review.toJson());

class CustomerReview {
  String? id;
  String? name;
  String? review;
  String? date;

  CustomerReview({this.id, this.name, this.review, this.date});

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id!,
      'name': name!,
      'review': review!,
    };
  }
}
