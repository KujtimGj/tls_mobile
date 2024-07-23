import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/screens/home/task_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getProcessingTickets() async {
    var provider =
        Provider.of<ProcessingTicketsProvider>(context, listen: false);

    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.getProcessingTickets(context);
    res.fold((falure) {}, (tickets) {
      provider.addTickets(tickets);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProcessingTickets();
  }

  @override
  Widget build(BuildContext context) {
    // var ticketProvider = Provider.of<TicketProvider>(context);
    var processingTicketProvider =
        Provider.of<ProcessingTicketsProvider>(context);
    Size size = MediaQuery.of(context).size;
    print(
      processingTicketProvider.getProcessingTickets().length,
    );
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
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
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
            Text(
              "Overview",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1, color: const Color(0xffeaeaea))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "0",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Waiting",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[500]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1, color: const Color(0xffeaeaea))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${processingTicketProvider.getProcessingTickets().length}",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "In process",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[500]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1, color: const Color(0xffeaeaea))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "0",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Finished",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[500]),
                                )
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
            Text(
              "Processing Tasks",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                TicketModel ticketModel =
                    processingTicketProvider.getProcessingTickets()[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TaskDetails(
                                    ticketModel: ticketModel,
                                  ))).then((value) {
                        getProcessingTickets();
                      });
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1, color: const Color(0xffeaeaea))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ticketModel.serviceCompany!.companyName,
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "NR:${ticketModel.ticketNumber}",
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 16),
                                        ),
                                        const SizedBox(width: 5,)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.grey[300],
                                  )),
                              const SizedBox(height: 4,),
                              Text(
                                ticketModel.client!.user!.fullname,
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              SizedBox(height: 8,),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    ticketModel.data!.problemDescription ??
                                        "",
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${ticketModel.client!.city}",
                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              Container(
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(15)),

                                child: const Row(
                                  children: [
                                    Icon(Icons.timelapse),
                                    Text(" 20 Jan")
                                  ],
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: processingTicketProvider.getProcessingTickets().length,
            )
          ],
        ),
      ),
    );
  }
}
