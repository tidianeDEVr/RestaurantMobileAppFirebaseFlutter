class ProductModel {
  String id;
  String libelle;
  DateTime addedAt;
  int price;
  List<String> components;

  ProductModel(
      {required this.id,
      required this.libelle,
      required this.addedAt,
      required this.price,
      required this.components});
}
