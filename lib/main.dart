import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:makan_apa_app/data/api/api_service.dart';
import 'package:makan_apa_app/data/db/database_helper.dart';
import 'package:makan_apa_app/data/model/restaurant.dart';
import 'package:makan_apa_app/data/preferences/preferences_helper.dart';
import 'package:makan_apa_app/provider/preferences_provider.dart';
import 'package:makan_apa_app/provider/restaurant_database_provider.dart';
import 'package:makan_apa_app/provider/restaurant_explore_provider.dart';
import 'package:makan_apa_app/provider/restaurant_search_provider.dart';
import 'package:makan_apa_app/ui/home_page.dart';
import 'package:makan_apa_app/ui/resto_detail_page.dart';
import 'package:makan_apa_app/utils/background_service.dart';
import 'package:makan_apa_app/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantExploreProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              RestaurantDatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Makan Apa ?',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                    brightness: provider.isDarkTheme
                        ? Brightness.dark
                        : Brightness.light),
                child: Material(
                  child: child,
                ),
              );
            },
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              RestoDetailPage.routeName: (context) => RestoDetailPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
            },
          );
        },
      ),
    );
  }
}
