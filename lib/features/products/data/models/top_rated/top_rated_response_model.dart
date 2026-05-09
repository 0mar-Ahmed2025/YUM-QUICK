// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

import 'package:yum_quick/features/products/data/models/top_rated/top_rated_model.dart';

class TopRatedResponseModel {
  bool? status;
  List<TopRatedProductsModel>? topRatedProducts;

  TopRatedResponseModel({this.status, this.topRatedProducts});

  TopRatedResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      topRatedProducts = <TopRatedProductsModel>[];
      json['products'].forEach((v) {
        if (v['rating'] == 5.0 || v['rating'] == 5) {
          topRatedProducts!.add(new TopRatedProductsModel.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.topRatedProducts != null) {
      data['products'] = this.topRatedProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
