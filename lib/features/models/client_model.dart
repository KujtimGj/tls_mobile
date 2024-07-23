import 'package:tls/features/models/user_model.dart';

class Client {
  String id;
  UserModel? user;
  String city;
  String state;
  String address;
  String latitude;
  String longitude;
  String description;
  bool active;
  String company;
  DateTime createdAt;
  DateTime updatedAt;

  Client({
    required this.id,
    required this.user,
    this.city = '',
    this.state = '',
    required this.address,
    this.latitude = '',
    this.longitude = '',
    this.description = '',
    this.active = true,
    required this.company,
    required this.createdAt,
    required this.updatedAt,
  });

  // Constructor to create a Client from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['_id'],
      user: UserModel.fromJson(json['user']),
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      address: json['address'],
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      description: json['description'] ?? '',
      active: json['active'] ?? true,
      company: json['company'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert a Client to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'city': city,
      'state': state,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'active': active,
      'company': company,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
