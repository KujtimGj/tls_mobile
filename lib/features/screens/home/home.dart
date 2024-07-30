import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/providers/user_provider.dart';
import 'package:tls/features/screens/home/tickets/processing_tickets.dart';
import 'package:tls/features/screens/home/tickets/waiting_tickets.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const route ="/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getPendingTickets() async {
    var provider = Provider.of<TicketProvider>(context, listen: false);

    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.getPendingTickets(context);
    res.fold((failure) {}, (tickets) {
      provider.addTickets(tickets);
    });
  }

  getProcessingTickets() async {
    var provider =
    Provider.of<ProcessingTicketsProvider>(context, listen: false);

    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.getProcessingTickets(context);
    res.fold((failure) {}, (tickets) {
      provider.addTickets(tickets);
    });
  }

  @override
  void initState() {
    super.initState();
    getPendingTickets();
    getProcessingTickets();
  }

  int selectedIndex = 0;

  final List<Widget> _tickets = [
    const WaitingTickets(),
    const ProcessingTickets(),
    const ProcessingTickets(),
  ];

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var ticketProvider = Provider.of<TicketProvider>(context);
    var processingTicketProvider =
        Provider.of<ProcessingTicketsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi ${userProvider.getUser()!.fullname}"),
            const Text(
              "Your task list for today",
              style: TextStyle(fontSize: 13, color: Color(0xff909090)),
            )
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
        child: RefreshIndicator(
          onRefresh: () async {
            getPendingTickets();
            getProcessingTickets();
          },
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
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Colors.grey[300]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1, color: const Color(0xffeaeaea))),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${ticketProvider.getPendingTickets().length}",
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
                                      "Waiting",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[500]),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = 1),
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Colors.grey[300]
                                : Colors.transparent,
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
                                          fontSize: 18,
                                          color: Colors.grey[500]),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = 2),
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedIndex == 2
                                ? Colors.grey[300]
                                : Colors.transparent,
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
                                          fontSize: 18,
                                          color: Colors.grey[500]),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                "Tasks ${selectedIndex == 0 ? "on wait" : selectedIndex == 1 ? "on process" : "completed"}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              _tickets[selectedIndex]
            ],
          ),
        ),
      ),
    );
  }
}
