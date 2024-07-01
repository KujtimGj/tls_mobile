import 'package:flutter/material.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/screens/home/task_details.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello User",style: TextStyle(fontWeight: FontWeight.w500),),
            Text("March, 2024",style: TextStyle(fontSize: 14,color: Colors.grey[400]),)
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network("https://www.freelanceri-ks.com/static/media/1.5435ddc7e99d7a47c48a.png"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const ClampingScrollPhysics(),
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
            const SizedBox(height: 10),
            Text("Overview",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: size.height*0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1,color: const Color(0xffeaeaea))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.done_all_outlined,size: 28,),
                                  Text("Finished",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:const Color(0xffe8ffeb)
                                ),
                                child: const Center(
                                  child: Text("+20%",style: TextStyle(color: Color(0xff58dc6b),fontWeight: FontWeight.w700),),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("33 Projects",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: size.height*0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1,color: const Color(0xffeaeaea))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.upcoming,size: 28,),
                                  Text("Upcoming",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:const Color(0xffe8ffeb)
                                ),
                                child: const Center(
                                  child: Text("+20%",style: TextStyle(color: Color(0xff58dc6b),fontWeight: FontWeight.w700),),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("8 Tickets",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text("My Tasks",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const TaskDetails()));
              },
              child: Container(
                height:size.height*0.2,
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1,color: const Color(0xffeaeaea))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TV Service",style: TextStyle(color: Colors.grey[500],fontSize: 16),),
                            const Text("Televisions to fix",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        const Icon(Icons.more_horiz_outlined,size: 35,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Row(
                            children: [
                              Icon(Icons.timelapse),
                              Text(" 20 Jan")
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("https://www.freelanceri-ks.com/static/media/1.5435ddc7e99d7a47c48a.png")
                            )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height:size.height*0.2,
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1,color: const Color(0xffeaeaea))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Heat Service",style: TextStyle(color: Colors.grey[500],fontSize: 16),),
                          const Text("Heating to fix",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      const Icon(Icons.more_horiz_outlined,size: 35,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Row(
                          children: [
                            Icon(Icons.timelapse),
                            Text(" 20 Jan")
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage("https://www.freelanceri-ks.com/static/media/1.5435ddc7e99d7a47c48a.png")
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
