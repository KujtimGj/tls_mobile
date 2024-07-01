import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

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
              const Text("Profile",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network("https://www.freelanceri-ks.com/static/media/4.97aa07241f899d4be54d.jpg",height: 60,),
                      SizedBox(width: 10),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Kujtim Gjokaj",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          Text("Servicer",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey[500]),)
                        ],
                      )
                    ],
                  ),
                  const Text("Log out",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red),)
                ],
              ),
              const SizedBox(height: 25),
              const Text("Notifications",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
