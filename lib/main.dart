import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trawell/utils/consts.dart';
import 'Screens/SplashScreen.dart';
import 'customer.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel' ,
      'High importance notifications',

      importance: Importance.high,
      playSound: true
  );


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // for web
  await Firebase.initializeApp();

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  debugPrint('receive background message');
  debugPrint('notification.title: ${notification?.title}');
  debugPrint('notification.body: ${notification?.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // for web
  await Firebase.initializeApp();

  // this code used when you want to show/do something when notification comes while the app is in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );


  runApp(MaterialApp(
    home: SplashScreen(),
    title: 'Travel App',
    debugShowCheckedModeBanner: false,
  ));
}