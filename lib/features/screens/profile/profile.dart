import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tls/core/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/features/screens/welcome/login.dart';

import '../../providers/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? fullName;
  String? email;
  @override
  void initState() {
    getMyAcc();
    super.initState();
  }

  getMyAcc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString("fullname");
      email = prefs.getString("email");
    });
    print(fullName);
    print(email);
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("fullname");
    prefs.remove("email");
    prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              const SizedBox(height: 25),
              const Text(
                "Profile",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: Icon(
                          Icons.pan_tool_alt_outlined,
                          size: 30,
                        ),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            email.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[500]),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Settings",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Container(
                height: 60,
                width: getPhoneWitdth(context),
                margin: const EdgeInsets.only(top: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: getPhoneHeight(context),
                          width: 50,
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Color(0xffeaeaea), shape: BoxShape.circle),
                          child: const Center(
                            child: Icon(Icons.report_problem_outlined),
                          ),
                        ),
                        const Text(
                          "Report an issue",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffeaeaea)),
                      child: const Center(
                          child: Icon(Icons.keyboard_arrow_right_sharp)),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                width: getPhoneWitdth(context),
                margin: const EdgeInsets.only(top: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: getPhoneHeight(context),
                          width: 50,
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Color(0xffeaeaea), shape: BoxShape.circle),
                          child: const Center(
                            child: Icon(Icons.call),
                          ),
                        ),
                        const Text(
                          "Contact administration",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffeaeaea)),
                      child: const Center(
                          child: Icon(Icons.keyboard_arrow_right_sharp)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                      (route) => false);
                },
                child: const Center(
                  child: Text(
                    "Log out",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
