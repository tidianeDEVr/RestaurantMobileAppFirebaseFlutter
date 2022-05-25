import 'package:cloud_firestore/cloud_firestore.dart';

class PayementService {
  late FirebaseFirestore firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }
}
