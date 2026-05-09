// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

import 'package:yum_quick/features/products/data/models/best_seller/best_seller_model.dart';

class BestSellerResponseModel {
  bool? status;
  List<BestSellerProductsModel>? bestSellerProducts;

  BestSellerResponseModel({this.status, this.bestSellerProducts});

  BestSellerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['best_seller_products'] != null) {
      bestSellerProducts = <BestSellerProductsModel>[];
      json['best_seller_products'].forEach((v) {
        if (v['best_seller'] != 0) {
          bestSellerProducts!.add(new BestSellerProductsModel.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bestSellerProducts != null) {
      data['best_seller_products'] = this.bestSellerProducts!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}
