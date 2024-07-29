

import 'package:intl/intl.dart';
import 'package:tls/features/models/product_model.dart';

class GeneralTicketData {
  String? id;
  String? manufacturer;
  String? serviceModel;
  String? serialNumber;
  String? reason;
  String? processingTime;
  String? workSchedule;
  String? clientSatisfaction;
  dynamic secondAddress;
  String? appointmentDate;
  String? servicePrice;
  String? problemDescription;
  List<Product>? product;
  bool? hasDiscount;
  String? discountPrice;

  GeneralTicketData({
    this.id,
    this.manufacturer,
    this.serviceModel,
    this.serialNumber,
    this.reason,
    this.processingTime,
    this.clientSatisfaction,
    this.workSchedule,
    this.secondAddress,
    this.appointmentDate,
    this.servicePrice,
    this.problemDescription,
    this.product,
    this.hasDiscount,
    this.discountPrice,
  });

  factory GeneralTicketData.fromJson(Map<String, dynamic> json) {

    List<Product> servicesList = json['product'] == null ? []:(json['product'] as List).map((e) => Product.fromJson(e)).toList();
    return GeneralTicketData(
      id: json['id'],
      manufacturer: json['manufacturer'],
      serviceModel: json['service_model'],
      serialNumber: json['serial_number'],
      reason: json['reason'],
      clientSatisfaction: json['clientSatisfaction'],
      processingTime: json['processing_time'],
      workSchedule: json['work_schedule'],
      secondAddress: json['second_address'],
      appointmentDate: json['appointment_data'],
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
      'reason': reason,
      'processing_time': processingTime,
      'work_schedule': workSchedule,
      'second_address': secondAddress,
      'appointment_date': appointmentDate,
      'service_price': servicePrice,
      'problem_description': problemDescription,
      'product': product!.map((item) => item.toJson()).toList(),
      'has_discount': hasDiscount,
      'discount_price': discountPrice,
    };
  }

  parseDate(){
    try{
      return DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(appointmentDate!));
    }catch(e){
      return "Uncorrect date format";
    }
  }
}