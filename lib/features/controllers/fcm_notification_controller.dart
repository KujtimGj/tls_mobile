import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/main.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";


Future<void> handleBackgroundMessage(RemoteMessage message)async{
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}


class FirebaseApi{
  final _firebaseMessage = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High important notifications',
    description: "This channel is used for important notifications.",
    importance: Importance.defaultImportance
  );

  final _localNotifications=FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message){
    if(message==null)return;
    // navigatorKey.currentState?.pushNamed(Home.route,arguments: message);
  }

  Future<void> initNotifications () async{
    await _firebaseMessage.requestPermission();
    final fcmToken = await _firebaseMessage.getToken();
    print("Token:$fcmToken");
    initLocalNotification();
    initPushNotifications();
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future initLocalNotification() async{
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android,iOS: iOS);

    await _localNotifications.initialize(settings,onDidReceiveNotificationResponse:(NotificationResponse response){
      final payload= response.payload;
      if(payload!=null){
        final message = RemoteMessage.fromMap(jsonDecode(payload));
        print("Received notification payload:$message");
      }
    });
    final platform =_localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  }

  Future initPushNotifications()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }
}