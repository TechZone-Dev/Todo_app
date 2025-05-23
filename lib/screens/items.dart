



class Item {
  String image;
  String name;
  String shortDisc;
  String longDisc;
  String price;

  Item({
    required this.image,
    required this.name,
    required this.shortDisc,
    required this.longDisc,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      shortDisc: json['shortDisc'] ?? '',
      longDisc: json['longDisc'] ?? '',
      price: json['price'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'shortDisc': shortDisc,
      'longDisc': longDisc,
      'price': price,
    };
  }
}