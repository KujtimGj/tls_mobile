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
  DateTime? createdAt;
  DateTime? updatedAt;
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
    return TicketModel(
      id: json['_id'],
      addedBy: json['added_by'],
      clientCompany: json['client_company'],
      serviceCompany: json['service_company'] != null
          ? ServiceCompany.fromJson(json['service_company'])
          : null,
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      body: json['data'],
      status: json['status'],
      servicePrice: json['service_price'],
      discountPrice: json['discount_price'] != null ? json['discount_price'] : 0,
      hasDiscount: json['has_discount'],
      images: json['images'] != null ? StorageModel.fromJson(json['images']) : null,
      technicians: json['technicians'] != null ? List<dynamic>.from(json['technicians']) : [],
      completed: json['completed'],
      deleted: json['deleted'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
      'service_company': serviceCompany?.toJson(),
      'client': client?.toJson(),
      'data': body,
      'status': status,
      'service_price': servicePrice,
      'discount_price': discountPrice,
      'has_discount': hasDiscount,
      'images': images?.toJson(),
      'technicians': technicians,
      'completed': completed,
      'deleted': deleted,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'ticket_number': ticketNumber,
      'products': products,
      '__v': v,
      'reason_comment': reasonComment,
    };
  }
}
