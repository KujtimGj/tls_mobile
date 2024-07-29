import 'package:intl/intl.dart';
import 'package:tls/features/models/client_model.dart';
import 'package:tls/features/models/product_model.dart';
import 'package:tls/features/models/service_company.dart';
import 'package:tls/features/models/storage_model.dart';
import 'package:tls/features/models/user_model.dart';

class TicketModel {
  String? id;
  String? addedBy;
  String? clientCompany;
  ServiceCompany? serviceCompany;
  Client? client;
  dynamic body;
  String? status;
  int? servicePrice;
  dynamic discountPrice;
  bool? hasDiscount;
  StorageModel? images;
  List<dynamic>? technicians;
  bool? completed;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? ticketNumber;
  int? products;
  int? v;
  String? reasonComment;

  TicketModel({
      this.id,
      this.addedBy,
      this.clientCompany,
      this.serviceCompany,
      this.client,
      this.body,
     this.status,
     this.servicePrice,
     this.discountPrice,
     this.hasDiscount,
     this.images,
     this.technicians,
     this.completed,
     this.deleted,
     this.createdAt,
     this.updatedAt,
     this.products,
     this.ticketNumber,
     this.v,
     this.reasonComment,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    print(json['images']);
    return TicketModel(
      id: json['_id'],
      addedBy: json['added_by'],
      clientCompany: json['client_company'],
      serviceCompany: ServiceCompany.fromJson(json['service_company']),
      client: Client.fromJson(json['client']),
      body: json['data'],
      status: json['status'],
      servicePrice: json['service_price'],
      discountPrice: json['discount_price'] == null ?"": "",
      hasDiscount: json['has_discount'],
      images: StorageModel.fromJson(json['images']),
      technicians: json['technicians'],
      completed: json['completed'],
      deleted: json['deleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      ticketNumber: json['ticket_number'],
      products: json['products'],
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
      'data': body,
      'status': status,
      'service_price': servicePrice,
      'discount_price': discountPrice,
      'has_discount': hasDiscount,
      'images': images!.toJson(),
      'technicians': technicians,
      'completed': completed,
      'deleted': deleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'ticket_number': ticketNumber,
      'products': products,
      '__v': v,
      'reason_comment': reasonComment,
    };
  }
}


