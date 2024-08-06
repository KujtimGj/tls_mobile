import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/models/user_model.dart';
import 'package:tls/features/providers/user_provider.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/features/screens/welcome/login.dart';
import 'package:tls/main.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key,required this.isLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print("splash");
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>widget.isLoggedIn? const Base():const Login()));
    });

  }

  // checkLogin(context) async {
  //
  //   var userProvider  = Provider.of<UserProvider>(context,listen: false);
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //
  //   var userData =   preferences.getString("tls_user");
  //
  //   if(userData != null){
  //     UserModel userModel = UserModel.fromJson(jsonDecode(userData));
  //     userProvider.addUser(userModel);
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Base()), (_) => true);
  //   }
  //   else{
  //     Navigator.pushAndRemoveUntil(context,
  //         MaterialPageRoute(builder: (_) => const Login()), (route) => true);
  //   }
  // }

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
