import 'package:flutter/material.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/controllers/ticket_controllers.dart';
import 'package:tls/features/models/product_model.dart';
import 'package:tls/features/models/ticket_products_model.dart';

class ProductList extends StatefulWidget {
  final String? ticketId;
  const ProductList({super.key, required this.ticketId});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<TicketProductModel> products = [];

  getProducts() async {
    TicketControllers ticketControllers = TicketControllers();
    var res = await ticketControllers.getProducts(context, widget.ticketId!);
    res.fold((failure) {}, (products) {
      setState(() {
        this.products = products;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 25,
            )),
        title: const Text("Products"),
      ),
      body:RefreshIndicator(
        onRefresh: () async {
          getProducts();
        },
        child: Container(
          width: getPhoneWitdth(context),
          height: getPhoneHeight(context),
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              TicketProductModel product = products[index];
              return Column(
                children: [
                  Container(
                    width: getPhoneWitdth(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title",style: TextStyle(fontSize: 13,color: Colors.grey[700]),),
                              Text(product.product.productTitle ?? ""),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Amount",style: TextStyle(fontSize: 13,color: Colors.grey[700]),),
                              Text("${product.amount}"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price",style: TextStyle(fontSize: 13,color: Colors.grey[700]),),
                              Text("${product.price}"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total",style: TextStyle(fontSize: 13,color: Colors.grey[700]),),
                              Text("${product.price * product.amount}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300],)
                ],
              );
            },
            itemCount: products.length,
          ),
        ),
      ),
    );
  }
}
