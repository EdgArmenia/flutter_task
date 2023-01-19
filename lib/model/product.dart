class Product {
  int? id;
  late String product;
  late int p1;
  late int p2;

  Product({
    required this.id,
    required this.product,
    required this.p1,
    required this.p2,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};

    map["id"] = id;
    map["product"] = product;
    map["p1"] = p1;
    map["p2"] = p2;

    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map["id"] as int;
    product = map["product"] as String;
    p1 = map["p1"] as int;
    p2 = map["p2"] as int;
  }
}
