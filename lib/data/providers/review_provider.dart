import 'dart:async';
import 'dart:io';

import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/data/api/api_services.dart';
import 'package:babe_resto/data/models/review.dart';
import 'package:flutter/material.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiServices apiService;

  CustomerReview? _review;
  String _message = '';
  Post? _state = Post.Idle;

  CustomerReview? get reviewRestaurant => _review;
  String get message => _message;
  Post? get state => _state;

  RestaurantReviewProvider({required this.apiService});

  void setState(Post newState) {
    _state = newState;
    notifyListeners();
  }

  Future<dynamic> postReviewByRestoId({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      _state = Post.Loading;
      notifyListeners();
      final restoReview = await apiService.postReviewById(
        id: id,
        name: name,
        review: review,
      );

      if (restoReview) {
        _state = Post.Success;
        notifyListeners();
        return _message = 'Success';
      }
    } on TimeoutException catch (e) {
      _state = Post.Error;
      notifyListeners();
      return _message = 'TIMEOUT: $e';
    } on SocketException catch (e) {
      _state = Post.Error;
      notifyListeners();
      return _message = 'NO CONNECTION: $e';
    } on Error catch (e) {
      _state = Post.Error;
      notifyListeners();
      return _message = 'ERROR: $e';
    }
  }
}
