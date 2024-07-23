import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/core/utils.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetails extends StatefulWidget {
  final TicketModel? ticketModel;
  const TaskDetails({super.key, required this.ticketModel});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  bool loading = false;


  acceptTicket() async {
    setState(() => loading = true);
    var provider = Provider.of<ProcessingTicketsProvider>(context,listen: false);
    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.ticketOnProcess(context, widget.ticketModel!.id!);
    res.fold((failure){
      setState(() => loading = false);
    }, (tickets){
      setState(() => loading = false);
      provider.addTicket(widget.ticketModel!);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Ticket is in process!");
    });
  }

  rejectTicket(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        width: getPhoneWitdth(context),
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Comment here",style: TextStyle(fontSize: 17),),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(

                  )
                ),
              )
            ],
          ),
        ),
      );
    });
  }
  returnTicket(){}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 25,
            )),
        title: Text("Ticket: ${widget.ticketModel!.ticketNumber ?? ""}"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              if (widget.ticketModel!.client!.latitude.isEmpty ||
                  widget.ticketModel!.client!.longitude.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Latitude or longditute is missing!");
              } else {
                try {
                  var url = getMapDirectionUrl(
                      widget.ticketModel!.client!.latitude,
                      widget.ticketModel!.client!.longitude);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                } catch (e) {
                }
              }
            },
            child: Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: const Icon(Icons.location_on_outlined),
            ),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const Text(
              "Company",
              style: TextStyle(),
        ),
            Text(
              widget.ticketModel!.serviceCompany!.companyName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20,thickness: 0.6,),
            const Text(
              "Problem description",
              style: TextStyle(),
            ),
            const SizedBox(height: 4,),
            Text(
              "${widget.ticketModel!.data!.problemDescription}",
              style: const TextStyle(
                fontSize: 19,height: 1.2
              ),
            ),
            const Divider(height: 20,thickness: 0.6,),
            const Text(
              "Address",
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.ticketModel!.client!.address,
              style: const TextStyle(

                  fontSize: 19,height: 1.2
              ),
            ),
            const Divider(height: 20,thickness: 0.6,),

            const Text(
              "Team Members",

            ),
            const SizedBox(height: 10),
            Row(
              children:
                  List.generate(widget.ticketModel!.technicians!.length, (i) {
                var technician = widget.ticketModel!.technicians![i];
                return Text(
                  "${technician['fullname']}",
                  style: const TextStyle(   fontSize: 19,height: 1.2),
                );
              }),
            ),
            const SizedBox(height: 25),

            const Text(
              "Deadline",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_sharp,
                      size: 25,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.ticketModel!.data!.parseDate() ?? "",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xffe8ffeb),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    statusText(),
                    style: const TextStyle(
                        color: Color(0xff58dc6b),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
           nextButton(size),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  statusText(){
    if(widget.ticketModel!.status == "pending"){
      return "On Progress";
    }
    else if(widget.ticketModel!.status == "processing"){
      return "On Processing";
    }
  }
  nextButton(size){
    if(widget.ticketModel!.status == "pending"){
      return  GestureDetector(
        onTap: () {
          rejectTicket();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => const StartedTicket()));
        },
        child: Container(
          height: 51,
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: const Color(0xff58dc6b),
              borderRadius: BorderRadius.circular(10)),
          child:   Center(
            child: loading ? const CircularProgressIndicator(strokeWidth: 1.8,color: Colors.white,):const Text(
              "Start ticket",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      );
    }
    else{
      return  Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                rejectTicket();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => const StartedTicket()));
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: const Color(0xffe73d4f),
                    borderRadius: BorderRadius.circular(10)),
                child:   Center(
                  child: loading ? const CircularProgressIndicator(strokeWidth: 1.8,color: Colors.white,):const Text(
                    "Reject",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: GestureDetector(
              onTap: () {
                returnTicket();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => const StartedTicket()));
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color:   const Color(0xff357ee5),
                    borderRadius: BorderRadius.circular(10)),
                child:   Center(
                  child: loading ? const CircularProgressIndicator(strokeWidth: 1.8,color: Colors.white,):const Text(
                    "Return",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: GestureDetector(
              onTap: () {
                acceptTicket();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => const StartedTicket()));
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color:   const Color(0xff156443),
                    borderRadius: BorderRadius.circular(10)),
                child:   Center(
                  child: loading ? const CircularProgressIndicator(strokeWidth: 1.8,color: Colors.white,):const Text(
                    "Complete",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
