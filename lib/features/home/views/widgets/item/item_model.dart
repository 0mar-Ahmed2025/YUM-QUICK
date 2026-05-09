class ItemModel {
  const ItemModel({
    required this.image,
    required this.itemName,
    required this.price,
    required this.rate,
    required this.description,
  });

  final String image;
  final String itemName;
  final double price;
  final double rate;
  final String description;
}
