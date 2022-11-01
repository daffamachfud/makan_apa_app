import 'package:makan_apa_app/data/model/drink.dart';
import 'package:makan_apa_app/data/model/food.dart';

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Food> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}
