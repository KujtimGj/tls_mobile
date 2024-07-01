import 'package:flutter/material.dart';

class StartedTicket extends StatelessWidget {
  const StartedTicket({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Television to fix"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: size.height*0.18,
                        width: size.width*0.4,
                        decoration: BoxDecoration(
                          color:Colors.grey[300],
                        ),
                        child: Center(
                          child: Icon(Icons.image,size: 55,color: Colors.grey[500],),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Before",style: TextStyle(fontSize: 20),)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: size.height*0.18,
                        width: size.width*0.4,
                        decoration: BoxDecoration(
                          color:Colors.grey[300],
                        ),
                        child: Center(
                          child: Icon(Icons.image,size: 55,color: Colors.grey[500],),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("After",style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ],
              ),

            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                enabled: false,
                decoration:const InputDecoration(
                    hintText: "Kujtim Gjokaj",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                enabled: false,
                decoration:const InputDecoration(
                  hintText: "Television Cable Change",
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1)
                  )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                enabled: false,
                decoration:const InputDecoration(
                    hintText: "LG Company",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                enabled: false,
                decoration:const InputDecoration(
                    hintText: "Address,18,Berlin",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Address,18,Berlin",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:const EdgeInsets.all(5),
                    focusColor: Colors.black,
                    border:const OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Start date",
                          suffixIcon:const Icon(Icons.calendar_month),
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          contentPadding:const EdgeInsets.all(5),
                          focusColor: Colors.black,
                          border:const OutlineInputBorder(
                              borderSide: BorderSide(width: 1)
                          )
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "End date",
                          suffixIcon:const Icon(Icons.calendar_month),
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          contentPadding:const EdgeInsets.all(5),
                          focusColor: Colors.black,
                          border:const OutlineInputBorder(
                              borderSide: BorderSide(width: 1)
                          )
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.alternate_email),
                    hintText: "Send payment to email",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:const EdgeInsets.all(5),
                    focusColor: Colors.black,
                    border:const OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0xff363636),
                borderRadius: BorderRadius.circular(5)
              ),
              child: const Center(
                child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
