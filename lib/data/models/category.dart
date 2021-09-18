class Category {
  String? name;

  Category({this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Menus {
  List<Category>? foods;
  List<Category>? drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Category>.from(
        json['foods'].map(
          (e) => Category.fromJson(e),
        ),
      ),
      drinks: List<Category>.from(
        json['drinks'].map(
          (e) => Category.fromJson(e),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };
}
