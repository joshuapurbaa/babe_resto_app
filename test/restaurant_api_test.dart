import 'dart:convert';
import 'dart:io';

import 'package:babe_resto/data/api/api_services.dart';
import 'package:babe_resto/data/models/list_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch restaurant api', () {
    final restaurantsExpected = [
      Restaurant(
          id: '1',
          name: 'restaurant',
          description: 'tempat makan minum',
          city: 'lampung',
          pictureId: '11223',
          rating: 55),
      Restaurant(
          id: '2',
          name: 'restaurant',
          description: 'tempat makan minum',
          city: 'lampung',
          pictureId: '11223',
          rating: 55),
      Restaurant(
          id: '3',
          name: 'restaurant',
          description: 'tempat makan minum',
          city: 'lampung',
          pictureId: '11223',
          rating: 55),
      Restaurant(
          id: '4',
          name: 'restaurant',
          description: 'tempat makan minum',
          city: 'lampung',
          pictureId: '11223',
          rating: 55),
    ];

    final responseExpected = RestaurantList(
        error: false,
        message: 'berhasil',
        count: 4,
        details: restaurantsExpected);

    test('should contain list of restaurant when api success', () async {
      //arrange
      final api = ApiServices();
      final mockClient = MockClient();

      //act
      var json = jsonEncode(responseExpected.toJson());
      when(
        mockClient.get(
          Uri.parse(ApiServices.baseUrl + ApiServices.list),
        ),
      ).thenAnswer((_) async => http.Response(json, 200));

      //assert
      var restaurantActual = await api.getRestaurantList(mockClient);
      expect(restaurantActual, isA<RestaurantList>());
    });

    test('should contain list of restaurant when api failed', () {
      //arrange
      final api = ApiServices();
      final mockClient = MockClient();

      when(
        mockClient.get(
          Uri.parse(ApiServices.baseUrl + ApiServices.list),
        ),
      ).thenAnswer((_) async =>
          http.Response('Failed to load list of restaurants', 404));

      var restaurantActual = api.getRestaurantList(mockClient);
      expect(restaurantActual, throwsException);
    });

    test('should contain list of restaurant when no internet connection', () {
      //arrange
      final api = ApiServices();
      final client = MockClient();

      when(
        client.get(
          Uri.parse(ApiServices.baseUrl + ApiServices.list),
        ),
      ).thenAnswer(
          (_) async => throw SocketException('No Internet Connection'));

      var restaurantActual = api.getRestaurantList(client);
      expect(restaurantActual, throwsException);
    });
  });
}
