import 'dart:async';
import 'dart:io';

import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/data/api/api_services.dart';
import 'package:babe_resto/data/models/list_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices apiService;

  RestaurantList? _listResto;
  String _message = '';
  ResultState? _state;

  RestaurantList? get listResto => _listResto;
  String get message => _message;
  ResultState? get state => _state;

  RestaurantListProvider({required this.apiService});

  Future<dynamic> fetchList() async {
    try {
      _state = ResultState.Loading;
      final list = await apiService.getRestaurantList(Client());

      if (list.count == 0) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = list.message!;
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listResto = list;
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
