import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/data/database/database_helper.dart';
import 'package:babe_resto/data/models/list_restaurant.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  DbProvider({required this.databaseHelper}) {
    _getFavsResto();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _resto = [];
  List<Restaurant> get favorites => _resto;

  void _getFavsResto() async {
    _resto = await databaseHelper.getFavsResto();
    if (_resto.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Daftar favorite masih kosong';
    }
    notifyListeners();
  }

  void addFavsResto(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavsResto();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error add: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavsResto(String id) async {
    final favsResto = await databaseHelper.getFavoriteById(id);
    return favsResto.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavsResto();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
