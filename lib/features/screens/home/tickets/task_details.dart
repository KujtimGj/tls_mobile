import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/core/utils.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/models/general_ticket_data.dart';
import 'package:tls/features/models/pickup_ticket_data.dart';
import 'package:tls/features/models/repair_ticket_data.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/providers/processing_tickets_provider.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/screens/home/tickets/bodies/general_body.dart';
import 'package:tls/features/screens/home/tickets/bodies/pickup_body.dart';
import 'package:tls/features/screens/home/tickets/bodies/repair_body.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetails extends StatefulWidget {
  final TicketModel? ticketModel;
  const TaskDetails({super.key, required this.ticketModel});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  TextEditingController _comment = TextEditingController();

  /// PickUp Fields
  TextEditingController inverterUsed = TextEditingController();
  TextEditingController installationDate = TextEditingController();
  bool operationOn = false;

  /// Repair Fields
  TextEditingController conductorResistance = TextEditingController();
  TextEditingController insulationResistance = TextEditingController();
  TextEditingController differentialCurrent = TextEditingController();
  bool isDamaged = false;
  bool hasGuarantee = false;
  bool isFunctional = false;
  bool isReplaced = false;
  bool receivedDevice = false;
  bool replaced = false;
  bool assembled = false;

  /// General Fields
  TextEditingController clientSatisfaction = TextEditingController();

  bool loading = false;

  List<XFile> beforeFiles = [];
  List<XFile> afterFiles = [];

  acceptTicket() async {
    setState(() => loading = true);
    var waitingProvider = Provider.of<TicketProvider>(context, listen: false);
    var provider =
        Provider.of<ProcessingTicketsProvider>(context, listen: false);
    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.ticketOnProcess(
        context, widget.ticketModel!.id!);
    res.fold((failure) {
      setState(() => loading = false);
    }, (tickets) {
      setState(() => loading = false);
      provider.addTicket(widget.ticketModel!);
      waitingProvider.removeTicket(widget.ticketModel!);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Ticket is in process!");
    });
  }

  rejectTicket() async {
    setState(() => loading = true);
    var provider =
        Provider.of<ProcessingTicketsProvider>(context, listen: false);
    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.rejectTicket(
        context, widget.ticketModel!.id!, _comment.text);
    res.fold((failure) {
      setState(() => loading = false);
    }, (tickets) {
      _comment.text = "";
      setState(() => loading = false);
      provider.removeTicket(widget.ticketModel!);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Ticket rejected successfully");
    });
  }

  returnTicket() async {
    setState(() => loading = true);
    var provider =
        Provider.of<ProcessingTicketsProvider>(context, listen: false);
    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.returnTicket(
        context, widget.ticketModel!.id!, _comment.text);
    res.fold((failure) {
      setState(() => loading = false);
    }, (tickets) {
      _comment.text = "";
      setState(() => loading = false);
      provider.addTicket(widget.ticketModel!);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Ticket returned successfully");
    });
  }

  completeTicket() async {
    var body = {};

    if (widget.ticketModel!.body['ticketmodel'] == "PickUp") {
      print("sdfsdf");
      body['installationDate'] = installationDate.text;
      body['inverterUsed'] = inverterUsed.text;
      body['isOperational'] = operationOn;
    } else if (widget.ticketModel!.body['ticketmodel'] == "General") {
      body['clientSatisfaction'] = clientSatisfaction.text;
    } else if (widget.ticketModel!.body['ticketmodel'] == "Repair") {
      body['conductorResistance'] = conductorResistance.text;
      body['insulationResistance'] = insulationResistance.text;
      body['differentialCurrent'] = differentialCurrent.text;
      body['differentialCurrent'] = differentialCurrent.text;
      body['isDamaged'] = isDamaged;
      body['hasGuarantee'] = hasGuarantee;
      body['isFunctional'] = isFunctional;
      body['isReplaced'] = isReplaced;
      body['receivedDevice'] = receivedDevice;
      body['replaced'] = replaced;
      body['assembled'] = assembled;
    }

    setState(() => loading = true);
    var provider =
        Provider.of<ProcessingTicketsProvider>(context, listen: false);
    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.completeTicket(
        context, widget.ticketModel!.id!, body);
    res.fold((failure) {
      setState(() => loading = false);
    }, (tickets) {
      _comment.text = "";
      setState(() => loading = false);
      // provider.addTicket(widget.ticketModel!);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Ticket completed successfully");
    });
  }

  rejectTicketModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: getPhoneWitdth(context),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Comment here",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _comment,
                    minLines: 3,
                    maxLines: 7,
                    decoration: InputDecoration(
                      enabled: false,
                        hintText: "Reason here...",
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_comment.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please type reason of rejection this ticket");
                        return;
                      }
                      Navigator.of(context).pop();
                      rejectTicket();
                    },
                    child: Container(
                      width: getPhoneWitdth(context),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffe73d4f),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 59,
                  ),
                ],
              ),
            ),
          );
        });
  }

  returnTicketModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: getPhoneWitdth(context),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Comment here",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _comment,
                    minLines: 3,
                    maxLines: 7,
                    decoration: InputDecoration(
                        hintText: "Reason here...",
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_comment.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please type reason of returning this ticket");
                        return;
                      }
                      Navigator.of(context).pop();
                      returnTicket();
                    },
                    child: Container(
                      width: getPhoneWitdth(context),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffe73d4f),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 59,
                  ),
                ],
              ),
            ),
          );
        });
  }

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
        title: Column(
          children: [
            Text("Ticket: ${widget.ticketModel!.ticketNumber ?? ""}"),
            Text(
              "${widget.ticketModel!.body['ticketmodel']}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
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
                } catch (e) {}
              }
            },
            child: Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: Icon(
                Icons.map,
                color: Colors.green[800],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const Text(
                "Client",
                style: TextStyle(),
              ),
              const SizedBox(
                height: 4,
              ),
              TextField(
                controller: TextEditingController(
                    text: widget.ticketModel!.client!.user!.fullname),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 13)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Address",
                style: TextStyle(),
              ),
              const SizedBox(
                height: 4,
              ),
              TextField(
                controller: TextEditingController(
                    text: widget.ticketModel!.client!.address),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 13)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Company",
                style: TextStyle(),
              ),
              const SizedBox(
                height: 4,
              ),
              TextField(
                controller: TextEditingController(
                    text: widget.ticketModel!.serviceCompany!.companyName),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 13)),
              ),
              const Divider(
                height: 30,
                thickness: 0.6,
              ),
              const Text(
                "Team Members",
              ),
              const SizedBox(height: 10),
              Column(
                children:
                    List.generate(widget.ticketModel!.technicians!.length, (i) {
                  var technician = widget.ticketModel!.technicians![i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[300]),
                          child: Center(
                              child: Icon(
                            Icons.person,
                            color: Colors.grey[500],
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${technician['fullname']}",
                          style: const TextStyle(fontSize: 19, height: 1.2),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const Divider(
                height: 30,
                thickness: 0.6,
              ),
              bodyNavigation(widget!.ticketModel!.body),
              const SizedBox(height: 25),
              nextButton(size),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  nextButton(size) {
    if (widget.ticketModel!.status == "pending") {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (contect) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Container(
                    width: getPhoneWitdth(context),
                    height: 200,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Are you sure you want to start this ticket?",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 46,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[400]),
                                  child: const Center(
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  acceptTicket();
                                },
                                child: Container(
                                  height: 46,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: const Color(0xff58dc6b)),
                                  child: const Center(
                                    child: Text(
                                      "Po",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
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
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    strokeWidth: 1.8,
                    color: Colors.white,
                  )
                : const Text(
                    "Start ticket",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                rejectTicketModal();

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
                child: Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.8,
                          color: Colors.white,
                        )
                      : const Text(
                          "Reject",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                returnTicketModal();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => const StartedTicket()));
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: const Color(0xff357ee5),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.8,
                          color: Colors.white,
                        )
                      : const Text(
                          "Return",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                completeTicket();
                // acceptTicket();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => const StartedTicket()));
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: const Color(0xff156443),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.8,
                          color: Colors.white,
                        )
                      : const Text(
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

  bodyNavigation(body) {
    print(body);
    if (body['ticketmodel'] == "General") {
      return GeneralBody(
          ticketModel: widget.ticketModel,
          generalTicketData: GeneralTicketData.fromJson(body),
      clientSatisfaction: (value){
        clientSatisfaction.text = value;
        setState(() {});
      },
      );
    } else if (body['ticketmodel'] == "Repair") {
      return RepairBody(
        ticketModel: widget.ticketModel,
        repairTicketData: RepairTicketData.fromJson(body),
        conductorResistance: (value) => setState(() => conductorResistance.text = value),
        insulationResistance: (value) => setState(() => insulationResistance.text = value),
        differentialCurrent: (value) => setState(() => differentialCurrent.text = value),
        isDamaged: (value) => isDamaged = value,
        hasGuarantee: (value) => setState(() => hasGuarantee = value),
        tested: (value) => isFunctional = value,
        receivedDevice: (value) => setState(() => receivedDevice = value),
        replaced: (value) => setState(() => replaced = value),
        assembled: (value) => setState(() => assembled = value),
      );
    } else if (body['ticketmodel'] == "PickUp") {
      return PickUpBody(
        ticketModel: widget.ticketModel,
        pickUpTicketData: PickUpTicketData.fromJson(body),
        installationDate: (text) {
          installationDate.text = text;
          setState(() {});
        },
        inverterUsed: (name) {
          inverterUsed.text = name;
          setState(() {});
        },
        isOperational: (value) {
          operationOn = value;
        },
      );
    }
  }
}
