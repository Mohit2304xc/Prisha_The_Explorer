class ShopModel {
  String id;
  String type;
  String description;
  String originalPrice;
  String salePrice;
  String name;
  List<String> category;
  List<String> images;

  ShopModel({
    required this.id,
    required this.type,
    required this.description,
    required this.originalPrice,
    required this.salePrice,
    required this.name,
    required this.category,
    required this.images,
  });

  factory ShopModel.fromJson(Map<String, dynamic> document) {
    return ShopModel(
      id: (document["id"]).toString(),
      type: document["type"] ?? "",
      description: document["description"] ?? "",
      name: document["name"] ?? "",
      originalPrice: document["original_price"] ?? "",
      salePrice: document["sale_price"] ?? "",
      category: document["category"] != null && document["category"] is List
          ? List<String>.from(document["category"])
          : [],
      images: document["images"] != null && document["images"] is List
          ? List<String>.from(document["images"])
          : [],
    );
  }
}
