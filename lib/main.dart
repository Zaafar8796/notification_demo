import 'package:flutter/material.dart';
import 'package:notifications/home_screen.dart';
import 'package:notifications/payload_screen.dart';

import '../api/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Notifications.init(initScheduled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? payload;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Notifications Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        'payload-screen': (context) => PayloadScreen(payload: payload),
      },
    );
  }
}
