import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import './common/navigation.dart';
import './data/api/api_services.dart';
import './data/database/database_helper.dart';
import './data/preferences/preferences_helper.dart';
import './data/providers/database_provider.dart';
import './data/providers/detail_provider.dart';
import './data/providers/list_provider.dart';
import './data/providers/preferences_provider.dart';
import './data/providers/review_provider.dart';
import './data/providers/scheduling_provider.dart';
import './data/providers/search_provider.dart';
import './page/bottom_nav.dart';
import './page/detail.dart';
import './page/favorite.dart';
import './page/home.dart';
import './page/review/review_page.dart';
import './page/review/tulis_review.dart';
import './utils/background_services.dart';
import './utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>.value(
          value: RestaurantListProvider(
            apiService: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>.value(
          value: RestaurantDetailProvider(
            apiService: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>.value(
          value: RestaurantSearchProvider(
            apiService: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<RestaurantReviewProvider>.value(
          value: RestaurantReviewProvider(
            apiService: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<DbProvider>.value(
          value: DbProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<PreferencesProvider>.value(
          value: PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>.value(
          value: SchedulingProvider(),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Babe Resto',
            theme: provider.themeData,
            initialRoute: BottomNav.routeName,
            routes: {
              BottomNav.routeName: (context) => BottomNav(),
              RestaurantHomePage.routeName: (context) => RestaurantHomePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                    id: ModalRoute.of(context)!.settings.arguments as String,
                  ),
              ReviewPage.routeName: (context) => ReviewPage(
                  id: ModalRoute.of(context)!.settings.arguments as String),
              TulisReview.routeName: (context) => TulisReview(
                    id: ModalRoute.of(context)!.settings.arguments as String,
                  ),
              FavoriteRestaurantPage.routeName: (context) =>
                  FavoriteRestaurantPage(),
            },
          );
        },
      ),
    );
  }
}
