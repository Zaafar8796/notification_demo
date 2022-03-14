import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Notifications {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    const sound = 'azan.mp3';
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('azan'),
      ),
      iOS: IOSNotificationDetails(
        sound: sound,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    //when app is closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
    if (initScheduled) {
      tz.initializeTimeZones();
    }
  }

  static void cancelAll() => _notifications.cancelAll();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async {
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future showDailyScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    // required DateTime scheduledDate,
  }) async {
    _notifications.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(const Time(15, 43)),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final pakistan = tz.getLocation('Asia/Karachi');
    final tz.TZDateTime now = tz.TZDateTime.now(pakistan);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      pakistan,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(now);
    print(scheduledDate);
    return scheduledDate;

    // return scheduledDate.isBefore(now)
    //     ? scheduledDate.add(const Duration(days: 1))
    //     : scheduledDate;
  }
}
