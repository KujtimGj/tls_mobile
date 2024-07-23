import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/providers/user_provider.dart';
import 'package:tls/features/screens/calendar/calendar.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/features/screens/map/map.dart';
import 'package:tls/features/screens/notifications/notifications.dart';
import 'package:tls/features/screens/welcome/splashscreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => TicketProvider()),
    ChangeNotifierProvider(create: (_) => ProcessingTicketsProvider()),
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TLS Services',
      home: SplashScreen(),
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

  int selectedIndex=0;
  static final List<Widget> widgetOptions=[
    const Home(),
    const Calendar(),
    const MapView(),
    const Notifications()
  ];

  void _onItemTapped(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              label: 'Notifications'
          )
        ],
      ),
    );
  }
}

