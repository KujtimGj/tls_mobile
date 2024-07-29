import 'package:intl/intl.dart';
import 'package:tls/features/models/product_model.dart';

class PickUpTicketData {
  String? id;
  String? manufacturer;
  String? memoryName;
  String? oldMemorySerialNumber;
  String? newMemorySerialNumber;
  String? installationDate;
  String? installerDetails;
  String? inverterUsed;
  bool? operationOn;
  String? appointmentDate;
  String? servicePrice;
  String? problemDescription;
  List<Product>? product;
  bool? hasDiscount;
  String? discountPrice;

  PickUpTicketData({
    this.id,
    this.manufacturer,
    this.memoryName,
    this.oldMemorySerialNumber,
    this.newMemorySerialNumber,
    this.installationDate,
    this.installerDetails,
    this.inverterUsed,
    this.operationOn,
    this.appointmentDate,
    this.servicePrice,
    this.problemDescription,
    this.product,
    this.hasDiscount,
    this.discountPrice,
  });

  factory PickUpTicketData.fromJson(Map<String, dynamic> json) {
    List<Product> servicesList = json['product'] == null ? [] : (json['product'] as List).map((e) => Product.fromJson(e)).toList();
    return PickUpTicketData(
      id: json['id'],
      manufacturer: json['manufacturer'],
      memoryName: json['memory_name'],
      oldMemorySerialNumber: json['old_memory_serial_number'],
      newMemorySerialNumber: json['new_memory_serial_number'],
      installationDate: json['installation_date'],
      installerDetails: json['installer_details'],
      appointmentDate: json['appointment_data'],
      operationOn: json['isOperational'],
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
      'memory_name': memoryName,
      'old_memory_serial_number': oldMemorySerialNumber,
      'new_memory_serial_number': newMemorySerialNumber,
      'installation_date': installationDate,
      'installer_details': installerDetails,
      'appointment_date': appointmentDate,
      'service_price': servicePrice,
      'problem_description': problemDescription,
      'product': product!.map((item) => item.toJson()).toList(),
      'has_discount': hasDiscount,
      'discount_price': discountPrice,
    };
  }

  String parseDate() {
    try {
      return DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(appointmentDate!));
    } catch (e) {
      return "Incorrect date format";
    }
  }
}
