import 'dart:async';
import 'dart:io';

import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/data/api/api_services.dart';
import 'package:babe_resto/data/models/list_restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices apiService;

  RestaurantList? _restoList;
  int? _founded;
  String? _message = '';
  ResultState? _state;

  RestaurantList? get searchResto => _restoList;
  int? get founded => _founded;
  String? get error => _message;
  ResultState? get state => _state;

  RestaurantSearchProvider({required this.apiService});

  Future<dynamic> fetchSearch({String query = ''}) async {
    try {
      _state = ResultState.Loading;
      final restaurant = await apiService.searchRestaurant(query: query);

      if (query.isEmpty) {
        _state = ResultState.Searching;
        notifyListeners();
        return _message = 'Searching';
      } else if (restaurant.founded == 0) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data tidak ada';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restoList = restaurant;
      }
    } on TimeoutException catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'TIMEOUT: $e';
    } on SocketException catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'NO CONNECTION: $e';
    } on Error catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'ERROR: $e';
    }
  }
}
