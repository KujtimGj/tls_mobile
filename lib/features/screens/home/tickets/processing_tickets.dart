import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/screens/home/tickets/task_details.dart';

class ProcessingTickets extends StatefulWidget {
  const ProcessingTickets({super.key});

  @override
  State<ProcessingTickets> createState() => _ProcessingTicketsState();
}

class _ProcessingTicketsState extends State<ProcessingTickets> {

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var processingTicketProvider = Provider.of<ProcessingTicketsProvider>(context);
    return ListView.builder(
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
                      const SizedBox(height: 8,),
                      SizedBox(
                          width:
                          MediaQuery.of(context).size.width - 80,
                          child: Text(
                            ticketModel.body['problem_description']??
                                "",
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10,),
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
    );
  }
}
