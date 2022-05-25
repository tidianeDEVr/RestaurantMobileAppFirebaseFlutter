import 'package:food_ui_kit/models/product.model.dart';

class MenuModel {
  String id;
  String libelle;
  String image;
  String category;
  List<ProductModel> products;

  MenuModel(
      {required this.id,
      required this.libelle,
      required this.image,
      required this.category,
      required this.products});

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'libelle': this.libelle,
        'image': this.image,
        'category': this.category,
        'products': this.products
      };

  static MenuModel fromJson(Map<String, dynamic> json) => MenuModel(
      id: json['id'],
      libelle: json['libelle'],
      image: json['image'],
      category: json['category'],
      products: json['products']);
}
