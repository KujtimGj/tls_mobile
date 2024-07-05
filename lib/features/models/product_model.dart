
class Product {
  String id;
  String product;
  String price;
  String qty;

  Product({
    required this.id,
    required this.product,
    required this.price,
    required this.qty,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      product: json['product'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product': product,
      'price': price,
      'qty': qty,
    };
  }
}