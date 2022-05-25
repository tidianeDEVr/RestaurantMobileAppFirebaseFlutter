import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../components/price_range_and_food_type.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class Info extends StatefulWidget {
  late QueryDocumentSnapshot<Object?> data;
  Info(QueryDocumentSnapshot<Object?> dataPassed) {
    data = dataPassed;
  }

  @override
  State<Info> createState() => _InfoState(data);
}

class _InfoState extends State<Info> {
  late QueryDocumentSnapshot<Object?> data;
  _InfoState(QueryDocumentSnapshot<Object?> dataPassed) {
    data = dataPassed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.33,
          child: Image.network(data['image']),
        ),
        VerticalSpacing(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['libelle'], style: kH3TextStyle),
              VerticalSpacing(of: 5),
              Text(
                data['products'].toString(),
                style: kBodyTextStyle,
              ),
              VerticalSpacing(of: 10),
              PriceRangeAndFoodtype(
                data['price'].toString(),
                foodType: ["Food"],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
