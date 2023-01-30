class ProductModel {
  final String? name;
  final String? desc;
  final String? image;
  final num? price;
  final String? category;
  final ProductType? type;

  ProductModel(
      {required this.name,
      required this.desc,
      required this.image,
      required this.price,
      required this.category,
      required this.type});

  factory ProductModel.fromJson(Map data) {
    return ProductModel(
      name: data["name"],
      desc: data["desc"],
      image: data["image"],
      price: data["price"],
      category: data["category"],
      type: data["type"],
    );
  }

  toJson() {
    return {
      "name": name,
      "desc": desc,
      "image": image,
      "price": price,
      "category": category,
      "type": type
    };
  }
}

enum ProductType { KG, PC }
