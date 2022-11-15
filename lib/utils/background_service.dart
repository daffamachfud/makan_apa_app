import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../data/api/api_service.dart';
import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    try {
      if (kDebugMode) {
        print("Alarm Fired !");
      }
      final NotificationHelper notificationHelper = NotificationHelper();
      var result = await ApiService().listExplore(http.Client());
      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, result);
    } catch (e) {
      if (kDebugMode) {
        print("error");
        print(e);
      }
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
