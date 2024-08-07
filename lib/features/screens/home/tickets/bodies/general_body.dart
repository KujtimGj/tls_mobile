import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/controllers/images_controllers.dart';
import 'package:tls/features/models/general_ticket_data.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/screens/home/tickets/bodies/ticket_images.dart';
import 'package:tls/features/screens/home/tickets/product_list.dart';

class GeneralBody extends StatefulWidget {
  final TicketModel? ticketModel;
  final GeneralTicketData? generalTicketData;
  final Function(String)? clientSatisfaction;
  const GeneralBody(
      {super.key,
      required this.generalTicketData,
      required this.ticketModel,
      required this.clientSatisfaction});

  @override
  State<GeneralBody> createState() => _GeneralBodyState();
}

class _GeneralBodyState extends State<GeneralBody> {
  TextEditingController clientSatisfaction = TextEditingController();

  List<XFile> beforeFiles = [];
  List<XFile> afterFiles = [];
  bool beforeFilesForDelete = false;
  bool afterFilesForDelete = false;
  bool uploadingBefore = false;
  bool uploadingAfter = false;

  addBeforeFiles({bool? isCamera}) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      if (isCamera == true) {
        XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
        if (file != null) beforeFiles.add(file);
      } else {
        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
        if (file != null) beforeFiles.add(file);
      }
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print("error opening isCamera: $isCamera");
      }
    }
  }

  addAfterFiles({bool? isCamera}) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      if (isCamera == true) {
        XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
        if (file != null) afterFiles.add(file);
      } else {
        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
        if (file != null) afterFiles.add(file);
      }
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print("error opening isCamera: $isCamera");
      }
    }
  }

  uploadImages(String imageType) async {
    if (imageType == "before") {
      uploadingBefore = true;
    } else {
      uploadingAfter = true;
    }
    setState(() {});
    ImagesControllers imagesControllers = ImagesControllers();
    var res = await imagesControllers.uploadImages(
        context,
        widget.ticketModel!.id!,
        imageType == "before" ? beforeFiles : afterFiles,
        imageType);
    res.fold((failure) {
      uploadingBefore = false;
      setState(() {});
    }, (value) {
      if (imageType == "before") {
        uploadingBefore = false;
        beforeFilesForDelete = false;
        widget.ticketModel!.images = value;
        beforeFiles = [];
      } else {
        uploadingAfter = false;
        afterFilesForDelete = false;
        widget.ticketModel!.images = value;
        afterFiles = [];
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      clientSatisfaction.text =
          widget.generalTicketData?.clientSatisfaction ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ticketModel!.status);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Model",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text: widget.generalTicketData!.serviceModel ?? ""),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Serial number",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text: widget.generalTicketData!.serialNumber ?? ""),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Call reason",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text: widget.generalTicketData!.serialNumber ?? ""),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Processing Time",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text: widget.generalTicketData!.processingTime ?? ""),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Work Schedule",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text: widget.generalTicketData!.workSchedule ?? ""),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 15,
        ),
        widget.generalTicketData!.secondAddress == null
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    height: 30,
                    thickness: 0.6,
                  ),
                  const Text(
                    "Second Address",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Contact Person", style: TextStyle()),
                  const SizedBox(height: 4),
                  TextField(
                    controller: TextEditingController(
                        text: widget.generalTicketData!
                                .secondAddress?['contact_person'] ??
                            ""),
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
                  const Text("Street", style: TextStyle()),
                  const SizedBox(height: 4),
                  TextField(
                    controller: TextEditingController(
                        text: widget.generalTicketData!
                                .secondAddress?['person_street'] ??
                            ""),
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
                  const Text("Zip Code", style: TextStyle()),
                  const SizedBox(height: 4),
                  TextField(
                    controller: TextEditingController(
                        text: widget
                                .generalTicketData!.secondAddress?['zipcode'] ??
                            ""),
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
                  const Text("Location", style: TextStyle()),
                  const SizedBox(height: 4),
                  TextField(
                    controller: TextEditingController(
                        text: widget.generalTicketData!
                                .secondAddress?['location'] ??
                            ""),
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
                  const Text("Second phone number", style: TextStyle()),
                  const SizedBox(height: 4),
                  TextField(
                    controller: TextEditingController(
                        text: widget.generalTicketData!
                                .secondAddress?['otherphone'] ??
                            ""),
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
                ],
              ),
        const Text(
          "Discount",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text:
                  widget.generalTicketData!.hasDiscount == true ? "Yes" : "No"),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Price",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text:
                  "${double.parse(widget.generalTicketData!.servicePrice!) - widget.generalTicketData!.getDiscountPrice()}€"),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 10,
        ),
        widget.ticketModel!.status != "processing"
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Images before ${widget.ticketModel!.images!.getFilesBeforeLength()}",
                            style: const TextStyle(fontSize: 17),
                          ),
                          widget.ticketModel!.images!.getFilesBeforeLength() ==
                                  0
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    if (widget.ticketModel!.images!
                                            .getFilesBeforeLength() ==
                                        0) return;

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => TicketImages(
                                                  storageModel: widget
                                                      .ticketModel!.images,
                                                  before: true,
                                                )));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Text(
                                      "See",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (beforeFilesForDelete) {
                            setState(() {
                              beforeFilesForDelete = false;
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 30),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            addBeforeFiles(isCamera: false);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Gallery",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Icon(
                                                    Icons.image,
                                                    size: 34,
                                                    color: Colors.grey[700],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 70,
                                            child: VerticalDivider()),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            addBeforeFiles(isCamera: true);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Camera",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Icon(
                                                    Icons.camera,
                                                    size: 34,
                                                    color: Colors.grey[700],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[200]!)),
                          padding: const EdgeInsets.all(10),
                          width: getPhoneWitdth(context),
                          child: beforeFiles.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload, color: Colors.grey[600]),
                                    Text(
                                      "Upload images",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: List.generate(
                                          beforeFiles.length, (index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              GestureDetector(
                                                onLongPress: () {
                                                  if (beforeFilesForDelete ==
                                                      false) {
                                                    setState(() =>
                                                        beforeFilesForDelete =
                                                            true);
                                                  }
                                                },
                                                onTap: () {
                                                  if (beforeFilesForDelete) {
                                                    beforeFiles.removeAt(index);

                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  width: 74,
                                                  height: 97,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey[300],
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: FileImage(File(
                                                              beforeFiles[index]
                                                                  .path)))),
                                                ),
                                              ),
                                              beforeFilesForDelete
                                                  ? Positioned(
                                                      top: -10,
                                                      right: -8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (beforeFilesForDelete) {
                                                            beforeFiles
                                                                .removeAt(
                                                                    index);
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color:
                                                                  Colors.red),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                  : const SizedBox()
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    beforeFiles.isEmpty
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (uploadingBefore) return;
                                                  uploadImages("before");
                                                },
                                                child: Container(
                                                  width:
                                                      getPhoneWitdth(context),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey),
                                                  child: Center(
                                                    child: uploadingBefore
                                                        ? const CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 1.9,
                                                          )
                                                        : const Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Images after ${widget.ticketModel!.images!.getFilesAfterLength()}",
                            style: const TextStyle(fontSize: 17),
                          ),
                          widget.ticketModel!.images!.getFilesAfterLength() == 0
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    if (widget.ticketModel!.images!
                                            .getFilesAfterLength() ==
                                        0) return;

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => TicketImages(
                                                  storageModel: widget
                                                      .ticketModel!.images,
                                                  before: false,
                                                )));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Text(
                                      "See",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (afterFilesForDelete) {
                            setState(() {
                              afterFilesForDelete = false;
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 30),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            addAfterFiles(isCamera: false);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Gallery",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Icon(
                                                    Icons.image,
                                                    size: 34,
                                                    color: Colors.grey[700],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 70,
                                            child: VerticalDivider()),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            addAfterFiles(isCamera: true);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "Camera",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Icon(
                                                    Icons.camera,
                                                    size: 34,
                                                    color: Colors.grey[700],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[200]!)),
                          padding: const EdgeInsets.all(10),
                          width: getPhoneWitdth(context),
                          child: afterFiles.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload, color: Colors.grey[600]),
                                    Text(
                                      "Upload images",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: List.generate(afterFiles.length,
                                          (index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              GestureDetector(
                                                onLongPress: () {
                                                  if (afterFilesForDelete ==
                                                      false) {
                                                    setState(() =>
                                                        afterFilesForDelete =
                                                            true);
                                                  }
                                                },
                                                onTap: () {
                                                  if (afterFilesForDelete) {
                                                    afterFiles.removeAt(index);
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  width: 74,
                                                  height: 97,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey[300],
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: FileImage(File(
                                                              afterFiles[index]
                                                                  .path)))),
                                                ),
                                              ),
                                              afterFilesForDelete
                                                  ? Positioned(
                                                      top: -10,
                                                      right: -8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (afterFilesForDelete) {
                                                            afterFiles.removeAt(
                                                                index);
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color:
                                                                  Colors.red),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 13,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                  : const SizedBox()
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    afterFiles.isEmpty
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (uploadingAfter) return;
                                                  uploadImages("after");
                                                },
                                                child: Container(
                                                  width:
                                                      getPhoneWitdth(context),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey),
                                                  child: Center(
                                                    child: uploadingAfter
                                                        ? const CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 1.9,
                                                          )
                                                        : const Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Problem description",
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: TextEditingController(
                        text:
                            widget.generalTicketData!.problemDescription ?? ""),
                    minLines: 5,
                    maxLines: 8,
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
                  const Text("Deadline"),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: TextEditingController(
                        text: widget.generalTicketData!.appointmentDate ?? ""),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.access_time_sharp,
                          size: 25,
                          color: Colors.grey[500],
                        ),
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
                ],
              ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Products",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          controller: TextEditingController(
              text: "${widget.ticketModel?.products ?? 0}"),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              suffixIcon: widget.ticketModel!.products == 0
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                ProductList(ticketId: widget.ticketModel!.id)));
                      },
                      child: Container(
                          color: Colors.transparent,
                          width: 70,
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Shiko",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ))),
                    ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Client Satisfaction",
          style: TextStyle(),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  clientSatisfaction.text = "Very Satisfied";
                  widget.clientSatisfaction!(clientSatisfaction.text);
                });
              },
              child: Container(
                width: getPhoneWitdth(context),
                height: 40,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Very Satisfied",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black87)),
                      padding: const EdgeInsets.all(3),
                      child: clientSatisfaction.text != "Very Satisfied"
                          ? const SizedBox()
                          : Container(
                              width: 21,
                              height: 21,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black87)),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  clientSatisfaction.text = "Satisfied";
                  widget.clientSatisfaction!(clientSatisfaction.text);
                });
              },
              child: Container(
                width: getPhoneWitdth(context),
                height: 40,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Satisfied",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black87)),
                      padding: const EdgeInsets.all(3),
                      child: clientSatisfaction.text != "Satisfied"
                          ? const SizedBox()
                          : Container(
                              width: 21,
                              height: 21,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black87)),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  clientSatisfaction.text = "Not Satisfied";
                  widget.clientSatisfaction!(clientSatisfaction.text);
                });
              },
              child: Container(
                width: getPhoneWitdth(context),
                height: 40,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Not Satisfied",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black87)),
                      padding: const EdgeInsets.all(3),
                      child: clientSatisfaction.text != "Not Satisfied"
                          ? const SizedBox()
                          : Container(
                              width: 21,
                              height: 21,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black87)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
