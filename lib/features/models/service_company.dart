

class ServiceCompany {
  String id;
  String companyName;

  ServiceCompany({
    required this.id,
    required this.companyName,
  });

  factory ServiceCompany.fromJson(Map<String, dynamic> json) {
    return ServiceCompany(
      id: json['_id'],
      companyName: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'company_name': companyName,
    };
  }
}