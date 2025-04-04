import 'dart:core';
import 'package:thuc_tap_1/utils/util.dart';

class FoodModel2 {
  String? id;
  String? imageStr;
  String? name;
  double? price;
  int? quantity;
  String? description;
  double? rating;

  double get total => (price ?? 0.0) * (quantity ?? 0);

  FoodModel2() {
    id = Util.getID();
  }

  factory FoodModel2.fromJson(Map<String, dynamic> json) => FoodModel2()
    ..id = json['id'] as String?
    ..imageStr = json['imageStr'] as String?
    ..name = json['name'] as String?
    ..price = json['price'] as double?
    ..quantity = json['quantity'] as int?
    ..description = json['description'] as String?
    ..rating = json['rating'] as double?;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageStr': imageStr,
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'rating': rating,
    };
  }
}
