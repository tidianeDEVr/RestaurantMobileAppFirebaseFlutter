import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ui_kit/components/buttons/primary_button.dart';
import 'package:food_ui_kit/constants.dart';
import 'package:food_ui_kit/screens/search/search_screen.dart';
import 'package:food_ui_kit/size_config.dart';

import '../../../services/command.service.dart';
import 'order_item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: CommandService.commands,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('Une erreur s\'est passee');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          final data = snapshot.requireData;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                VerticalSpacing(),
                // List of cart items
                ...List.generate(
                  demoItems.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: OrderedItemCard(
                      title: data.docs[index]["menus"],
                      description: DateTime.parse(data.docs[index]
                                  ['commandedAt']
                              .toDate()
                              .toString())
                          .toString(),
                      numOfItem: data.docs.length,
                      price: data.docs[index]["amount"],
                    ),
                  ),
                ),
                // buildPriceRow(text: "Subtotal", price: 28.0),
                // VerticalSpacing(of: 10),
                buildPriceRow(text: "Livraison", price: 2000),
                VerticalSpacing(of: 10),
                // buildTotal(price: 20),
                VerticalSpacing(of: 40),
                PrimaryButton(
                  text: "Catalogue",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Row buildTotal({required double price}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text.rich(
        TextSpan(
          text: "Total ",
          style: kBodyTextStyle.copyWith(
              color: kMainColor, fontWeight: FontWeight.w500),
          children: [
            TextSpan(
              text: "(incl. VAT)",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      Text(
        "\$$price",
        style: kBodyTextStyle.copyWith(
            color: kMainColor, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

Row buildPriceRow({required String text, required double price}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: kBodyTextStyle.copyWith(color: kMainColor),
      ),
      Text(
        "\$$price",
        style: kBodyTextStyle.copyWith(color: kMainColor),
      )
    ],
  );
}

const List<Map> demoItems = [
  {
    "title": "Cookie Sandwich",
    "price": 7.4,
    "numOfItem": 1,
  },
  {
    "title": "Combo Burger",
    "price": 12,
    "numOfItem": 1,
  },
  {
    "title": "Oyster Dish",
    "price": 8.6,
    "numOfItem": 2,
  },
];
