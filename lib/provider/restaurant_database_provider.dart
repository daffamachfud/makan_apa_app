import 'package:flutter/foundation.dart';
import 'package:makan_apa_app/data/db/database_helper.dart';

import '../data/model/restaurant.dart';
import '../utils/result_state.dart';

class RestaurantDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantDatabaseProvider({required this.databaseHelper}){
    _getFavorites();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorite();
    if(_favorites.isNotEmpty){
      _state = ResultState.hasData;
    }else{
      _state = ResultState.noData;
      _message = 'Belum ada restoran favorite nih, cari yuk!';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try{
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    }catch (e) {
      _state = ResultState.error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void deleteFavorite(String id) async {
    try{
      await databaseHelper.deleteFavoriteById(id);
      _getFavorites();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }



}