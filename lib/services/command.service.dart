import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommandService {
  static final Stream<QuerySnapshot> commands =
      FirebaseFirestore.instance.collection('commands').snapshots();
  late FirebaseFirestore firestore;
  static final DocumentReference =
      FirebaseFirestore.instance.collection('commands').doc();
  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  makeCommand(Map<String, dynamic> commandToAdd) async {
    DocumentReference.set(commandToAdd).whenComplete(() =>
        Fluttertoast.showToast(
                msg: 'La commande a été effectuer avec succès',
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP)
            .onError((error, stackTrace) => Fluttertoast.showToast(
                msg: 'Une erreur s\'est produite !',
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP)));
  }
}
