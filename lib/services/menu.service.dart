import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MenuService {
  static final Stream<QuerySnapshot> menus =
      FirebaseFirestore.instance.collection('menus').snapshots();
  static final Stream<QuerySnapshot> menus2 =
      FirebaseFirestore.instance.collection('menus').snapshots();
  initialise() {}
  static getfinalData(AsyncSnapshot<QuerySnapshot> snapshot) {
    {
      if (snapshot.hasError) {
        return Text('Une erreur s\'est passee');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text('Loading');
      }
      return snapshot.requireData;
    }
  }
}
