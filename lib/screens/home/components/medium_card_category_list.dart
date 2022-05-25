import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/cards/medium/restaurant_info_medium_card.dart';
import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';
import '../../../demoData.dart';
import '../../../size_config.dart';

class MediumCardCategoryList extends StatefulWidget {
  const MediumCardCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  _MediumCardCategoryListState createState() => _MediumCardCategoryListState();
}

class _MediumCardCategoryListState extends State<MediumCardCategoryList> {
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
    // only for demo
    List data = categoriesList..shuffle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenWidth(254),
          child: isLoading
              ? buildFeaturedPartnersLoadingIndicator()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: (data.length - 1) == index ? kDefaultPadding : 0,
                    ),
                    child: RestaurantInfoMediumCard(
                      image: data[index]['image'],
                      name: data[index]['name'],
                      location: data[index]['location'],
                      delivertTime: 25,
                      rating: 4.6,
                      press: () {
                        Fluttertoast.showToast(
                            msg: data[index]['libelle'],
                            backgroundColor: Colors.green,
                            gravity: ToastGravity.TOP);
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
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
