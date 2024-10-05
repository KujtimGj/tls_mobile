import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/features/controllers/fcm_notification_controller.dart';
import 'package:tls/features/providers/finished_tickets_provider.dart';
import 'package:tls/features/providers/notifications_provider.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/providers/user_provider.dart';
import 'package:tls/features/screens/notifications/notifications.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/features/screens/map/map.dart';
import 'package:tls/features/screens/profile/profile.dart';
import 'package:tls/features/screens/welcome/splashscreen.dart';
import 'package:tls/firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // if (Platform.isAndroid) {
  //   await FlutterBackground.initialize();
  //   await FirebaseApi().initNotifications();
  // }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => TicketProvider()),
      ChangeNotifierProvider(create: (_) => ProcessingTicketsProvider()),
      ChangeNotifierProvider(create: (_) => FinishedTicketsProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ],
    child: MyApp(
      isLoggedIn: isLoggedIn,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TLS Services',
      home: SplashScreen(isLoggedIn: isLoggedIn),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int selectedIndex = 0;
  static final List<Widget> widgetOptions = [
    const Home(),
    const MapView(),
    const Notifications(),
    const Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  asd() async {
    print(await FirebaseMessaging.instance.getToken());
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<NotificationProvider>(context);
   asd();
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  prov.getUnreadNotifications() == 0 ? const SizedBox():Positioned(
                      right: 0,
                      top: -10,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text(
                          "${prov.getUnreadNotifications()}",
                          style: const TextStyle(color: Colors.white),
                        )),
                      ))
                ],
              ),
              label: "Notifications"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'Profile')
        ],
      ),
    );
  }
}
