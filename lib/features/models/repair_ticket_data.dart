import 'package:intl/intl.dart';
import 'package:tls/features/models/product_model.dart';

class RepairTicketData {
  String? id;
  String? manufacturer;
  String? serviceModel;
  String? serialNumber;
  String? conductorResistance;
  String? insulationResistance;
  String? differentialCurrent;
  bool? isDamaged;
  bool? hasGuarantee;
  bool? isFunctional;
  bool? isReplaced;
  bool? receivedDevice;
  bool? replaced;
  bool? assembled;
  String? buyDate;
  String? appointmentDate;
  String? servicePrice;
  String? problemDescription;
  List<Product>? product;
  bool? hasDiscount;
  String? discountPrice;

  RepairTicketData({
    this.id,
    this.manufacturer,
    this.serviceModel,
    this.serialNumber,
    this.conductorResistance,
    this.insulationResistance,
    this.differentialCurrent,
    this.isDamaged,
    this.hasGuarantee,
    this.isFunctional,
    this.isReplaced,
    this.receivedDevice,
    this.replaced,
    this.assembled,
    this.buyDate,
    this.appointmentDate,
    this.servicePrice,
    this.problemDescription,
    this.product,
    this.hasDiscount,
    this.discountPrice,
  });

  factory RepairTicketData.fromJson(Map<String, dynamic> json) {
    List<Product> servicesList = json['product'] == null ? [] : (json['product'] as List).map((e) => Product.fromJson(e)).toList();
    return RepairTicketData(
      id: json['id'],
      manufacturer: json['manufacturer'],
      serviceModel: json['service_model'],
      serialNumber: json['serial_number'],
      conductorResistance: json['conductorResistance'],
      insulationResistance: json['insulationResistance'],
      differentialCurrent: json['differentialCurrent'],
      isDamaged: json['isDamaged'],
      hasGuarantee: json['hasGuarantee'],
      isFunctional: json['isFunctional'],
      isReplaced: json['isReplaced'],
      receivedDevice: json['receivedDevice'],
      replaced: json['replaced'],
      assembled: json['assembled'],
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

  String parseDate() {
    try {
      return DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(appointmentDate!));
    } catch (e) {
      return "Incorrect date format";
    }
  }
}
