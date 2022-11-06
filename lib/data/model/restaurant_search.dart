import 'package:makan_apa_app/data/model/restaurant.dart';

class SearchResult {
  SearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from((json["restaurants"] as List)
            .map((x) => Restaurant.fromJson(x))
            .where((restaurant) =>
                restaurant.id != null &&
                restaurant.name != null &&
                restaurant.description != null &&
                restaurant.pictureId != null &&
                restaurant.city != null &&
                restaurant.rating != null)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
