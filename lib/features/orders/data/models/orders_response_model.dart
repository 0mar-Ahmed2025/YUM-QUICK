// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

class OrdersResponseModel {
  OrdersModel? orders;
  bool? status;

  OrdersResponseModel({this.orders, this.status});

  OrdersResponseModel.fromJson(Map<String, dynamic> json) {
    orders = json['orders'] != null
        ? new OrdersModel.fromJson(json['orders'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class OrdersModel {
  List<ActiveModel>? active;
  List<CanceledModel>? canceled;
  List<CompletedModel>? completed;

  OrdersModel({this.active, this.canceled, this.completed});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['active'] != null) {
      active = <ActiveModel>[];
      json['active'].forEach((v) {
        active!.add(new ActiveModel.fromJson(v));
      });
    }
    if (json['canceled'] != null) {
      canceled = <CanceledModel>[];
      json['canceled'].forEach((v) {
        canceled!.add(new CanceledModel.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <CompletedModel>[];
      json['completed'].forEach((v) {
        completed!.add(new CompletedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.active != null) {
      data['active'] = this.active!.map((v) => v.toJson()).toList();
    }
    if (this.canceled != null) {
      data['canceled'] = this.canceled!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActiveModel {
  DriverModel? driver;
  int? id;
  List<ItemsModel>? items;
  String? orderChangeDate;
  String? orderDate;
  double? shipping;
  int? status;
  double? subtotal;
  double? tax;
  double? total;

  ActiveModel({
    this.driver,
    this.id,
    this.items,
    this.orderChangeDate,
    this.orderDate,
    this.shipping,
    this.status,
    this.subtotal,
    this.tax,
    this.total,
  });

  ActiveModel.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != null
        ? new DriverModel.fromJson(json['driver'])
        : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <ItemsModel>[];
      json['items'].forEach((v) {
        items!.add(new ItemsModel.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}

class DriverModel {
  double? latitude;
  double? longitude;
  String? name;
  String? phone;

  DriverModel({this.latitude, this.longitude, this.name, this.phone});

  DriverModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class ItemsModel {
  String? description;
  int? id;
  String? imagePath;
  String? name;
  double? price;
  int? quantity;
  double? rating;
  double? totalPrice;

  ItemsModel({
    this.description,
    this.id,
    this.imagePath,
    this.name,
    this.price,
    this.quantity,
    this.rating,
    this.totalPrice,
  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    rating = json['rating'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['rating'] = this.rating;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class CanceledModel {
  DriverModel? driver;
  int? id;
  List<ItemsModel>? items;
  String? orderChangeDate;
  String? orderDate;
  double? shipping;
  int? status;
  double? subtotal;
  double? tax;
  double? total;

  CanceledModel({
    this.driver,
    this.id,
    this.items,
    this.orderChangeDate,
    this.orderDate,
    this.shipping,
    this.status,
    this.subtotal,
    this.tax,
    this.total,
  });

  CanceledModel.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != null
        ? new DriverModel.fromJson(json['driver'])
        : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <ItemsModel>[];
      json['items'].forEach((v) {
        items!.add(new ItemsModel.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}

class CompletedModel {
  DriverModel? driver;
  int? id;
  List<ItemsModel>? items;
  String? orderChangeDate;
  String? orderDate;
  double? shipping;
  int? status;
  double? subtotal;
  double? tax;
  double? total;

  CompletedModel({
    this.driver,
    this.id,
    this.items,
    this.orderChangeDate,
    this.orderDate,
    this.shipping,
    this.status,
    this.subtotal,
    this.tax,
    this.total,
  });

  CompletedModel.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != null
        ? new DriverModel.fromJson(json['driver'])
        : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <ItemsModel>[];
      json['items'].forEach((v) {
        items!.add(new ItemsModel.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}
