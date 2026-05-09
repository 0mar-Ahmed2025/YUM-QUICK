// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

import 'package:yum_quick/features/products/data/models/get_products/get_products_model.dart';

class GetProductResponseModel {
  List<ProductsModel>? products;
  bool? status;

  GetProductResponseModel({this.products, this.status});

  GetProductResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products!.add(new ProductsModel.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
