import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

// ignore: must_be_immutable
class AddToOrderScrreen extends StatelessWidget {
  late QueryDocumentSnapshot<Object?> data;
  AddToOrderScrreen(QueryDocumentSnapshot<Object?> dataPassed) {
    data = dataPassed;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Body(data),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            padding: EdgeInsets.zero,
            primary: Colors.black.withOpacity(0.5),
          ),
          child: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
