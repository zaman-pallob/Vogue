import 'package:Vogue/Product/Items.dart';

class Model {
  String name;
  String number;
  List<Items> items;

  Model({this.name, this.number, this.items});

  Model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
