import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:makan_apa_app/data/api/api_service.dart';
import 'package:makan_apa_app/data/model/restaurant_detail.dart';

import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant(restaurantId ?? "");
  }

  late RestaurantDetailResult _detailRestaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  ResultState get state => _state;

  RestaurantDetailResult get result => _detailRestaurant;

  Future<dynamic> _fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(restaurantId);
      if (restaurant.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
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
