import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/features/screens/welcome/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const Login()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: getPhoneHeight(context),
        width: getPhoneWitdth(context),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "TLS",
              style: TextStyle(
                  fontSize: 65, fontFamily: 'Kanit', fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
