class Product {
  String? id;
  String? productCode;
  String? productTitle;
  String? productModel;
  double? productPrice;
  int? productAmount;
  String? description;
  bool? sold;
  bool? active;
  bool? deleted;
  String? productCategory;
  String? clientCompany;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
      this.productCode,
      this.productTitle,
      this.productModel,
      this.productPrice,
      this.productAmount,
    this.description,
    this.sold = false,
    this.active = true,
    this.deleted = false,
      this.productCategory,
      this.clientCompany,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
  ;
    if(json['product_code'] == null){
      return Product();
    }
    return Product(
      id: json['_id'],
      productCode: json['product_code'] == null ? null :json['product_code'],
      productTitle: json['product_title'],
      productModel: json['product_model'],
      productPrice: (json['product_price'] as num).toDouble(),
      productAmount: json['product_amount'],
      description: json['description'],
      sold: json['sold'],
      active: json['active'],
      deleted: json['deleted'],
      productCategory: json['product_category'],
      clientCompany: json['client_company'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_code': productCode,
      'product_title': productTitle,
      'product_model': productModel,
      'product_price': productPrice,
      'product_amount': productAmount,
      'description': description,
      'sold': sold,
      'active': active,
      'deleted': deleted,
      'product_category': productCategory,
      'client_company': clientCompany,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
