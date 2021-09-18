import 'dart:async';
import 'dart:io';

import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/data/api/api_services.dart';
import 'package:babe_resto/data/models/detail_restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices apiService;

  RestaurantDetail? _resto;
  String _message = '';
  ResultState? _state;

  RestaurantDetail? get detailResto => _resto;
  String get message => _message;
  ResultState? get state => _state;

  RestaurantDetailProvider({required this.apiService});

  Future<dynamic> fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;
      final resto = await apiService.getRestaurantDetailById(id: id);

      if (resto.detail == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = resto.message!;
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _resto = resto;
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
