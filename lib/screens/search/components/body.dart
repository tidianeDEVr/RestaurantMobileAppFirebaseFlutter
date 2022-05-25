import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui_kit/constants.dart';
import 'package:food_ui_kit/size_config.dart';
import '../../../components/cards/big/restaurant_info_big_card_menu.dart';
import '../../../components/scalton/big_card_scalton.dart';
import '../../../services/menu.service.dart';
import '../../addToOrder/add_to_order_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  bool _showSearchResult = false;
  // ignore: unused_field
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void showResult() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showSearchResult = true;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(of: 10),
            Text('Catalogue', style: kH2TextStyle),
            VerticalSpacing(),
            buildSearchForm(),
            VerticalSpacing(),
            Text(_showSearchResult ? "Resultats de reserche" : "Top Menus",
                style: kSubHeadTextStyle),
            VerticalSpacing(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: MenuService.menus2,
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
                  return ListView.builder(
                    itemCount: _isLoading ? 2 : data.docs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: kDefaultPadding),
                      child: _isLoading
                          ? BigCardScalton()
                          : RestaurantInfoBigCardMenu(
                              image: data.docs[index]['image'],
                              name: data.docs[index]['libelle'],
                              rating: 4.3,
                              numOfRating: 200,
                              deliveryTime: 25,
                              price: data.docs[index]['price'],
                              press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddToOrderScrreen(data.docs[index]),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form buildSearchForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        onChanged: (value) {
          // get data while typing
          if (value.length >= 3) showResult();
        },
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            // If all data are correct then save data to out variables
            _formKey.currentState!.save();

            // Once user pree on submit
            showResult();
          } else {}
        },
        validator: requiredValidator,
        style: kSecondaryBodyTextStyle,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Recherchez sur Brasil Burger",
          contentPadding: kTextFieldPadding,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              color: kBodyTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
