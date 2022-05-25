import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  late FirebaseFirestore firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }
}
