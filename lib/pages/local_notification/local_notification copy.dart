// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // static void initilize() {
  //   const InitializationSettings initializationSettings =
  //       const InitializationSettings(
  //           android: AndroidInitializationSettings("@mipmap/ic_launcher"));
  //   _notificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: (String? payload) {
  //     print(payload);
  //   });
  // }

  // static void showNotificationOnForeground(RemoteMessage message) {
  //   final notificationDetail = const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //           "com.akshatharaa.toyskart_admin", "firebase_push_notification",
  //           importance: Importance.max, priority: Priority.high));

  //   _notificationsPlugin.show(
  //       DateTime.now().microsecond,
  //       message.notification!.title,
  //       message.notification!.body,
  //       notificationDetail,
  //       payload: message.data["message"]);
  // }

}
