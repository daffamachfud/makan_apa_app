import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:makan_apa_app/data/api/api_service.dart';
import 'package:makan_apa_app/data/model/restaurant_search.dart';
import 'package:makan_apa_app/provider/restaurant_explore_provider.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late SearchResult _searchResult = [] as SearchResult;
  String _message = '';
  ResultState _state = ResultState.noData;

  String get message => _message;

  ResultState get state => _state;

  SearchResult get result => _searchResult;

  Future<dynamic> searchQuery(String query) async {
    if (query.isEmpty) {
      _state = ResultState.noData;
      notifyListeners();
      return _message = 'Empty Data';
    }
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
