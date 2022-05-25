import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ui_kit/screens/addToOrder/add_to_order_screen.dart';

import '../../../components/cards/medium/restaurant_info_mediam_api_card.dart';
import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';
import '../../../services/menu.service.dart';
import '../../../size_config.dart';

class MediumCardList extends StatefulWidget {
  const MediumCardList({
    Key? key,
  }) : super(key: key);

  @override
  _MediumCardListState createState() => _MediumCardListState();
}

class _MediumCardListState extends State<MediumCardList> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    late QuerySnapshot<Object?> data;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: double.infinity,
          height: getProportionateScreenWidth(254),
          child: isLoading
              ? buildFeaturedPartnersLoadingIndicator()
              : StreamBuilder<QuerySnapshot>(
                  stream: MenuService.menus,
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
                    data = snapshot.requireData;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              left: kDefaultPadding,
                              right: (data.docs.length - 1) == index
                                  ? kDefaultPadding
                                  : 0,
                            ),
                            child: RestaurantInfoMediumApiCard(
                              image: Image.network(data.docs[index]['image']),
                              name: data.docs[index]['libelle'],
                              location: data.docs[index]['products'].toString(),
                              delivertTime: 25,
                              rating: 4.6,
                              press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddToOrderScrreen(data.docs[index]),
                                ),
                              ),
                            )));
                  },
                )),
    ]);
  }

  SingleChildScrollView buildFeaturedPartnersLoadingIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: MediumCardScalton(),
          ),
        ),
      ),
    );
  }
}
