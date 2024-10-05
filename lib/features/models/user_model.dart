class UserModel {
  String id;
  String fullname;
  String username;
  String birthdate;
  String phoneNumber;
  String email;
  String role;
  Company? company;
  String? fcmToken;
  bool active;
  bool deleted;
  String createdAt;
  String updatedAt;
  int v;
  Employee? employee;

  UserModel({
    required this.id,
    required this.fullname,
    required this.username,
    required this.birthdate,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.company,
    required this.fcmToken,
    required this.active,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
      this.employee,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullname: json['fullname'],
      username: json['username'],
      birthdate: json['birthdate'] ?? "",
      phoneNumber: json['phone_number'],
      email: json['email'],
      role: json['role'],
      company: json['company'].runtimeType == String? Company(id: json['company']): Company.fromJson(json['company']),
      fcmToken: json['fcm_token'],
      active: json['active'],
      deleted: json['deleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      employee:json['employee'] == null ? null: Employee.fromJson(json['employee']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'username': username,
      'birthdate': birthdate,
      'phone_number': phoneNumber,
      'email': email,
      'role': role,
      'company': company!.toJson(),
      'active': active,
      'deleted': deleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'employee': employee!.toJson(),
    };
  }
}

class Company {
  String id;
  String? clientCompanyName;
  String? createdAt;
  String? updatedAt;
  int? v;

  Company({
    required this.id,
      this.clientCompanyName,
      this.createdAt,
      this.updatedAt,
      this.v,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'],
      clientCompanyName: json['client_company_name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'client_company_name': clientCompanyName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class Employee {
  String id;
  String user;
  String address;
  String salary;
  String createdAt;
  String updatedAt;
  int v;

  Employee({
    required this.id,
    required this.user,
    required this.address,
    required this.salary,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'],
      user: json['user'],
      address: json['address'],
      salary: json['salary'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'address': address,
      'salary': salary,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
