class Items {
  String name;
  int qty;
  int price;
  Items(this.name, this.qty, this.price);

  Map<String, dynamic> tojsonData() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["quantity"] = qty;
    map["price"] = price;
    return map;
  }
}
