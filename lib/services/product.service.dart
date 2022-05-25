import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  late FirebaseFirestore firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }
}
