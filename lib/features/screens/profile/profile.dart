import 'package:flutter/material.dart';
import 'package:tls/core/dimensions.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Kujtim Gjokaj",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Servicer",
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
              const SizedBox(height: 25),
              const Text(
                "Last task",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Container(
                height: 60,
                width: getPhoneWitdth(context),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffeaeaea),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: getPhoneHeight(context),
                      width: 50,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TV Service",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "LG",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff909090)),
                        )
                      ],
                    )
                  ],
                ),
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
                            child: Icon(Icons.notifications_active_outlined),
                          ),
                        ),
                        const Text(
                          "Notifications",
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
              SizedBox(height: 30),
              Center(
                child: Text(
                  "Log out",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.red,fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
