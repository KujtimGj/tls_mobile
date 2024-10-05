import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/controllers/images_controllers.dart';
import 'package:tls/features/models/repair_ticket_data.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/screens/home/tickets/bodies/ticket_images.dart';
import 'package:tls/features/screens/home/tickets/product_list.dart';

class RepairBody extends StatefulWidget {
  final TicketModel? ticketModel;
  final RepairTicketData? repairTicketData;
  final Function(String)? conductorResistance;
  final Function(String)? insulationResistance;
  final Function(String)? differentialCurrent;
  final Function(bool)? isDamaged;
  final Function(bool)? hasGuarantee;
  final Function(bool)? tested;
  final Function(bool)? receivedDevice;
  final Function(bool)? replaced;
  final Function(bool)? assembled;
  const RepairBody({
    super.key,
    required this.repairTicketData,
    required this.ticketModel,
    required this.conductorResistance,
    required this.insulationResistance,
    required this.differentialCurrent,
    required this.isDamaged,
    required this.hasGuarantee,
    required this.tested,
    required this.receivedDevice,
    required this.replaced,
    required this.assembled,
  });

  @override
  State<RepairBody> createState() => _RepairBodyState();
}

class _RepairBodyState extends State<RepairBody> {
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
     conductorResistance.text = widget.repairTicketData?.conductorResistance ?? "";
    insulationResistance.text = widget.repairTicketData?.insulationResistance ?? "";
    differentialCurrent.text = widget.repairTicketData?.differentialCurrent ?? "";
    isDamaged = widget.repairTicketData?.isDamaged ?? false;
    hasGuarantee = widget.repairTicketData?.hasGuarantee ?? false;
    isFunctional = widget.repairTicketData?.isFunctional ?? false;
    isReplaced = widget.repairTicketData?.isReplaced ?? false;
    receivedDevice = widget.repairTicketData?.receivedDevice ?? false;
    replaced = widget.repairTicketData?.replaced ?? false;
    assembled = widget.repairTicketData?.assembled ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Produkte",
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
                            "Images before ${widget.ticketModel?.images?.getFilesBeforeLength() ?? ""}",
                            style: const TextStyle(fontSize: 17),
                          ),
                          widget.ticketModel?.images?.getFilesBeforeLength() ==
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
                            "Images after ${widget.ticketModel?.images?.getFilesAfterLength() ?? ""}",
                            style: const TextStyle(fontSize: 17),
                          ),
                          widget.ticketModel?.images?.getFilesAfterLength() == 0
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
                            widget.repairTicketData!.parseDate(),
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Protective conductor resistance ( < 0.3Ohms)",
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: conductorResistance,
                    onChanged: (value){
                      widget.conductorResistance!(value);
                    },
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
                    "Insulation resistance ( < 1 megohm)",
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: insulationResistance,
                    onChanged: (value){
                      widget.insulationResistance!(value);
                    },
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
                    "Differential current (< 3.5mA)",
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: differentialCurrent,
                    onChanged: (value){
                      widget.differentialCurrent!(value);
                    },
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDamaged = !isDamaged;
                        widget.isDamaged!(true);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Transport damage detected",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: isDamaged
                                            ? Colors.black87
                                            : Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hasGuarantee = !hasGuarantee;
                        widget.hasGuarantee!(true);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Proof of guarantee",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: hasGuarantee
                                            ? Colors.black87
                                            : Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFunctional = !isFunctional;
                        widget.tested!(true);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Functional test performed",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: isFunctional
                                            ? Colors.black87
                                            : Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        receivedDevice = !receivedDevice;
                        widget.receivedDevice!(true);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Received device",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: receivedDevice
                                            ? Colors.black87
                                            : Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        replaced = !replaced;
                        widget.replaced!(true);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Replaced device",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: replaced
                                            ? Colors.black87
                                            : Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        assembled = !assembled;
                        widget.assembled!(true);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Device assembly",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: assembled
                                            ? Colors.black87
                                            : Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
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
