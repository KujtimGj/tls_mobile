
class Client {
  String id;
  String fullname;
  String username;
  String phoneNumber;
  String email;
  String createdAt;
  String updatedAt;
  int v;

  Client({
    required this.id,
    required this.fullname,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['_id'],
      fullname: json['fullname'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'username': username,
      'phone_number': phoneNumber,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}