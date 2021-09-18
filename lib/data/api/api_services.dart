import 'package:babe_resto/data/models/detail_restaurant.dart';
import 'package:babe_resto/data/models/list_restaurant.dart';
import 'package:babe_resto/data/models/review.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  static const String imageUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static const String largeImageUrl =
      'https://restaurant-api.dicoding.dev/images/large/';
  static const String list = '/list';
  static const String detail = '/detail/';
  static const String search = '/search?q=';
  static const String reviews = '/review';

  // final http.Client client;
  // ApiServices(this.client);

  Future<RestaurantList> getRestaurantList(http.Client client) async {
    final response = await client.get(
      Uri.parse(baseUrl + list),
    );
    if (response.statusCode == 200) {
      return restaurantsFromJson(response.body);
    } else {
      throw Exception('Gagal mendapatkan data restaurant list!');
    }
  }

  Future<RestaurantDetail> getRestaurantDetailById({required String id}) async {
    final response = await http.get(
      Uri.parse(baseUrl + detail + id),
    );
    if (response.statusCode == 200) {
      return restaurantFromJson(response.body);
    } else {
      throw Exception('Gagal mendapatkan data restaurant detail!');
    }
  }

  Future<RestaurantList> searchRestaurant({required String query}) async {
    final response = await http.get(
      Uri.parse(baseUrl + search + query),
    );
    if (response.statusCode == 200) {
      return restaurantFromSearchJson(response.body);
    } else {
      throw Exception('Gagal mendapatkan data search result!');
    }
  }

  Future<bool> postReviewById({
    required String id,
    required String name,
    required String review,
  }) async {
    final body = CustomerReview(
      id: id,
      name: name,
      review: review,
    );

    final request = await http.post(
      Uri.parse(baseUrl + reviews),
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': '12345',
      },
      body: reviewToJson(body),
    );
    if (request.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal menambahkan review!');
    }
  }
}
