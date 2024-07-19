import 'package:tls/features/models/client_model.dart';
import 'package:tls/features/models/product_model.dart';
import 'package:tls/features/models/service_company.dart';

class TicketModel {
  String? id;
  String? addedBy;
  String? clientCompany;
  ServiceCompany? serviceCompany;
  Client? client;
  TicketData? data;
  String? status;
  int? servicePrice;
  dynamic discountPrice;
  bool? hasDiscount;
  List<dynamic>? imagesBefore;
  List<dynamic>? imagesAfter;
  List<String>? technicians;
  bool? completed;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? ticketNumber;
  int? v;
  String? reasonComment;

  TicketModel({
      this.id,
      this.addedBy,
      this.clientCompany,
      this.serviceCompany,
      this.client,
      this.data,
     this.status,
     this.servicePrice,
     this.discountPrice,
     this.hasDiscount,
     this.imagesBefore,
     this.imagesAfter,
     this.technicians,
     this.completed,
     this.deleted,
     this.createdAt,
     this.updatedAt,
     this.ticketNumber,
     this.v,
     this.reasonComment,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {

    return TicketModel(
      id: json['_id'],
      addedBy: json['added_by'],
      clientCompany: json['client_company'],
      serviceCompany: ServiceCompany.fromJson(json['service_company']),
      client: Client.fromJson(json['client']),
      data: TicketData.fromJson(json['data']),
      status: json['status'],
      servicePrice: json['service_price'],
      discountPrice: json['discount_price'] == null ?"": "",
      hasDiscount: json['has_discount'],
      imagesBefore: List<dynamic>.from(json['images_before']),
      imagesAfter: List<dynamic>.from(json['images_after']),
      technicians: List<String>.from(json['technicians']),
      completed: json['completed'],
      deleted: json['deleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      ticketNumber: json['ticket_number'],
      v: json['__v'],
      reasonComment: json['reason_comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'added_by': addedBy,
      'client_company': clientCompany,
      'service_company': serviceCompany!.toJson(),
      'client': client!.toJson(),
      'data': data!.toJson(),
      'status': status,
      'service_price': servicePrice,
      'discount_price': discountPrice,
      'has_discount': hasDiscount,
      'images_before': imagesBefore,
      'images_after': imagesAfter,
      'technicians': technicians,
      'completed': completed,
      'deleted': deleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'ticket_number': ticketNumber,
      '__v': v,
      'reason_comment': reasonComment,
    };
  }
}


class TicketData {
  String? id;
  String? manufacturer;
  String? serviceModel;
  String? serialNumber;
  String? buyDate;
  String? appointmentDate;
  String? servicePrice;
  String? problemDescription;
  List<Product>? product;
  bool? hasDiscount;
  String? discountPrice;

  TicketData({
     this.id,
     this.manufacturer,
     this.serviceModel,
     this.serialNumber,
     this.buyDate,
     this.appointmentDate,
     this.servicePrice,
     this.problemDescription,
     this.product,
     this.hasDiscount,
     this.discountPrice,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) {

    List<Product> servicesList = json['product'] == null ? []:(json['product'] as List).map((e) => Product.fromJson(e)).toList();
    return TicketData(
      id: json['id'],
      manufacturer: json['manufacturer'],
      serviceModel: json['service_model'],
      serialNumber: json['serial_number'],
      buyDate: json['buy_date'],
      appointmentDate: json['appointment_date'],
      servicePrice: json['service_price'],
      problemDescription: json['problem_description'],
      product: servicesList,
      hasDiscount: json['has_discount'],
      discountPrice: json['discount_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manufacturer': manufacturer,
      'service_model': serviceModel,
      'serial_number': serialNumber,
      'buy_date': buyDate,
      'appointment_date': appointmentDate,
      'service_price': servicePrice,
      'problem_description': problemDescription,
      'product': product!.map((item) => item.toJson()).toList(),
      'has_discount': hasDiscount,
      'discount_price': discountPrice,
    };
  }
}

