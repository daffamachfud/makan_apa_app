import 'package:makan_apa_app/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:makan_apa_app/data/model/restaurant_detail.dart';
import 'package:makan_apa_app/data/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/.';
  static const String _list = 'list';
  static const String _detail = "detail";
  static const String _search = "search?q=";

  Future<RestaurantResult> listExplore(http.Client client) async {
    final response = await client.get(Uri.parse("$_baseUrl/$_list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantDetailResult> detailRestaurant(String restaurantId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/$_detail/$restaurantId"));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to detail restaurant');
    }
  }

  Future<SearchResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/$_search$query"));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to detail restaurant');
    }
  }
}
