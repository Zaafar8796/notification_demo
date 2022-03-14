import 'package:flutter/material.dart';
import 'package:notifications/api/notifications.dart';
import 'package:notifications/payload_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Notifications.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    Notifications.onNotifications.stream.listen((onClickedNotification));
  }

  void onClickedNotification(String? payload) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PayloadScreen(payload: payload),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notifications Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   children: [
              //     const Text('Fajar'),
              //     const Expanded(child: SizedBox()),
              //     const Text('06 : 10 am'),
              //     IconButton(
              //       onPressed: () {
              //         // Notifications.showNotification(
              //         //   title: 'Namaz Fajar',
              //         //   body: 'Its time to offer namaz',
              //         //   payload: 'Fajar',
              //         // );
              //         // Notifications.showDailyScheduledNotification(
              //         //   title: 'Namaz Fajar',
              //         //   body: 'Its time to offer namaz',
              //         //   payload: 'Fajar',
              //         //   // scheduledDate: DateTime.now().add(
              //         //   //   const Duration(seconds: 10),
              //         //   // ),
              //         // );
              //       },
              //       icon: const Icon(Icons.alarm),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 40,
              // ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  child: const Text('Instant Notification'),
                  onPressed: () {
                    Notifications.showNotification(
                      title: 'Namaz Fajar',
                      body: 'Its time to offer namaz',
                      payload: 'Fajar',
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  child: const Text('Scheduled Notification'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'The notification will be shown after 10 seconds.',
                        ),
                      ),
                    );
                    Notifications.showScheduledNotification(
                      title: 'Namaz Fajar',
                      body: 'Its time to offer namaz',
                      payload: 'Fajar',
                      scheduleDate: DateTime.now().add(
                        const Duration(seconds: 10),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Notifications.cancelAll();
                },
                child: const Text('Cancel All'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
