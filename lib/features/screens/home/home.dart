import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/screens/home/task_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  getPendingTickets() async{
    TicketControllers ticketControllers = TicketControllers();
    await ticketControllers.getPendingTickets(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPendingTickets();
  }

  @override
  Widget build(BuildContext context) {
    var ticketProvider = Provider.of<TicketProvider>(context);
    Size size = MediaQuery.of(context).size;
    print(ticketProvider.getPendingTickets().length,);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TLS Service"),
          ],
        ),
        surfaceTintColor: Colors.transparent,

        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            // TextFormField(
            //   decoration: InputDecoration(
            //     hintText: "Search",
            //     prefixIcon: Icon(Icons.search,size: 30,color: Colors.grey[500],),
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide.none,
            //       borderRadius: BorderRadius.circular(35)
            //     ),
            //     filled: true,
            //     fillColor: const Color(0xfff5f5f5)
            //   ),
            // ),
            // const SizedBox(height: 10),
            Text("Overview",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1,color: const Color(0xffeaeaea))
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("0",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Waiting",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1,color: const Color(0xffeaeaea))
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("0",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("In process",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1,color: const Color(0xffeaeaea))
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("0",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Finished",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text("My Tasks",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),),
            const SizedBox(height: 15),
            ListView.builder(shrinkWrap: true,physics: const ClampingScrollPhysics(),itemBuilder: (context, index){
              TicketModel ticketModel = ticketProvider.getPendingTickets()[index];
              return GestureDetector(
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
                            Text("Manufacturer",style: TextStyle(color: Colors.grey[500],fontSize: 16),),
                            Text(ticketModel.serviceCompany!.companyName,style: TextStyle(color: Colors.grey[500],fontSize: 16),),
                              Text(ticketModel.data!.problemDescription ?? "",style: const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
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
              );
            },itemCount: ticketProvider.getPendingTickets().length,)
          ],
        ),
      ),
    );
  }
}
