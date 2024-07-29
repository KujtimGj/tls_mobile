import 'package:tls/features/models/product_model.dart';

class TicketProductModel {
  String? id;
  String ticket;
  Product product;
  int amount;
  double price;
  DateTime? createdAt;
  DateTime? updatedAt;

  TicketProductModel({
    this.id,
    required this.ticket,
    required this.product,
    required this.amount,
    required this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory TicketProductModel.fromJson(Map<String, dynamic> json) {
    return TicketProductModel(
      id: json['_id'],
      ticket: json['ticket'],
      product: Product.fromJson(json['product']),
      amount: json['amount'],
      price: (json['price'] as num).toDouble(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ticket': ticket,
      'product': product,
      'amount': amount,
      'price': price,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
