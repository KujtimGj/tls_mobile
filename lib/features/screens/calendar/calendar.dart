import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8,vertical: 10),
            child: Text("Timeline",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
          ),
          SizedBox(
            height: 100,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  width: 60,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: index==3?Colors.blue:Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1,color: const Color(0xffeaeaea))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${index+1}",style: TextStyle(color: index==3?Colors.white:Colors.black,fontSize: 17),)
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("09:00",style: TextStyle(color: Colors.grey[400]),),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    width: size.width,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(width: 1,color:const Color(0xffeaeaea))
                    ),
                    child:  Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Daily Task",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                            Text("Tuesday,9 Jan, Hamburg",style: TextStyle(color: Colors.grey[500]),)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("10:00",style: TextStyle(color: Colors.grey[400]),),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    width: size.width,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(width: 1,color:const Color(0xffeaeaea))
                    ),
                    child:  Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Project B",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                            Text("Tuesday,9 Jan, Hamburg",style: TextStyle(color: Colors.grey[500]),)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
