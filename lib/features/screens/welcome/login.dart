import 'package:flutter/material.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/main.dart';

import '../../../core/dimensions.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: getPhoneWitdth(context) * 0.08),
          child: ListView(
            children: [
              SizedBox(height: getPhoneHeight(context) * 0.1),
              const Center(
                child: Text(
                  "TLS",
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 30, fontFamily: 'Kanit'),
              ),
              const SizedBox(height: 40),
              const Text("Email",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: TextFormField(
                  decoration:  InputDecoration(
                    hintText: "user@email.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1, color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:const BorderSide(width: 1, color: Colors.grey)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Password",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "*******",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1, color: Color(0xffeaeaea))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1, color: Color(0xffeaeaea))),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Base()),
                          (route) => false);
                },
                child: Container(
                  height: getPhoneHeight(context) * 0.07,
                  width: getPhoneWitdth(context),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Forgot passowrd?",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              )
            ],
          ),
        ));
  }
}
