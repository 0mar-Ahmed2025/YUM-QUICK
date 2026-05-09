// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

import 'package:yum_quick/features/sliders/data/models/slider_model.dart';

class GetSlidersReponseModel {
  bool? status;
  List<SliderModel>? sliders;

  GetSlidersReponseModel({this.status, this.sliders});

  GetSlidersReponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['sliders'] != null) {
      sliders = <SliderModel>[];
      json['sliders'].forEach((v) {
        sliders!.add(new SliderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
