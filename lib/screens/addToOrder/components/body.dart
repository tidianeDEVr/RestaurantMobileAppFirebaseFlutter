import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ui_kit/components/buttons/primary_button.dart';
import 'package:food_ui_kit/constants.dart';
import 'package:food_ui_kit/screens/orderDetails/order_details_screen.dart';
import 'package:food_ui_kit/size_config.dart';

import 'info.dart';
import 'rounded_button.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  late QueryDocumentSnapshot<Object?> data;
  Body(QueryDocumentSnapshot<Object?> dataPassed) {
    data = dataPassed;
  }
  @override
  _BodyState createState() => _BodyState(data);
}

class _BodyState extends State<Body> {
  late QueryDocumentSnapshot<Object?> data;
  _BodyState(QueryDocumentSnapshot<Object?> dataPassed) {
    data = dataPassed;
  }
  // for demo we select 2nd one
  int choiceOfTopCookie = 1;
  int choiceOfBottomCookie = 1;
  int numOfItems = 1;

  // Collection Commands
  CollectionReference commands =
      FirebaseFirestore.instance.collection('commands');
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Info(data),
            VerticalSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(
                    of: 55,
                  ),
                  VerticalSpacing(),
                  // Num of item
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // increment button
                      RoundedButton(
                        press: () {
                          setState(() {
                            numOfItems++;
                          });
                        },
                        iconData: Icons.add,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Text(numOfItems.toString().padLeft(2, "0"),
                            style: kSubHeadTextStyle),
                      ),
                      // decrement buuton
                      RoundedButton(
                        press: () {
                          if (numOfItems > 1)
                            setState(() {
                              numOfItems--;
                            });
                        },
                        iconData: Icons.remove,
                      ),
                    ],
                  ),
                  VerticalSpacing(),
                  PrimaryButton(
                    text: "Passer commande",
                    press: () {
                      makeCommand(commands, auth, data, numOfItems);
                      Fluttertoast.showToast(
                          msg: 'Commande reussie 🎊',
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.green,
                          gravity: ToastGravity.TOP);
                      ;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            VerticalSpacing()
          ],
        ),
      ),
    );
  }
}

makeCommand(commands, auth, menu, quant) {
  final User user = auth.currentUser;
  commands.add({
    'client': user.email,
    'commandedAt': DateTime.now(),
    'menus': menu['libelle'],
    'quantity': quant,
    'ready': false,
    'payed': false,
    'amount': int.parse(menu['price']) * quant,
  });
}

const List<String> choiceOfTopCookies = [
  "Choice of top Cookie",
  "Cookies and Cream",
  "Funfetti",
  "M and M",
  "Red Velvet",
  "Peanut Butter",
  "Snickerdoodle",
  "White Chocolate Macadamia",
];
