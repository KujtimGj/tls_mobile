import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search,size: 30,color: Colors.grey[500],),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(35)
                  ),
                  filled: true,
                  fillColor: const Color(0xfff5f5f5)
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 height: 60,
                 width: 60,
                 decoration:const BoxDecoration(
                   color: Color(0xffeaeaea),
                   shape: BoxShape.circle
                 ),
                 child: const Center(
                   child: Icon(Icons.notification_important_outlined,color: Colors.black,size: 30,),
                 ),
               ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("One TV Service task in Bavaria",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      Text("10:00, 01/08/2024",style: TextStyle(color: Color(0xff909090)),),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
