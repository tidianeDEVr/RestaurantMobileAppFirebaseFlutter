import 'package:flutter/material.dart';
import 'package:food_ui_kit/screens/search/search_screen.dart';

import '../../../components/section_title.dart';
import '../../../screens/home/components/promotion_banner.dart';
import '../../../components/cards/big/big_card_image_slide.dart';
import '../../../demoData.dart';
import '../../../size_config.dart';
import 'medium_card_category_list.dart';
import 'medium_card_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(of: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BigCardImageSlide(images: demoBigImages),
            ),
            VerticalSpacing(of: 25),
            SectionTitle(
              title: "Les plus appreciés",
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              ),
            ),
            VerticalSpacing(of: 15),
            MediumCardList(),
            VerticalSpacing(of: 25),
            // Banner
            PromotionBanner(),
            VerticalSpacing(of: 25),
            SectionTitle(
              title: "Catégories",
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              ),
            ),
            VerticalSpacing(of: 15),
            MediumCardCategoryList(),
            VerticalSpacing(of: 25),
          ],
        ),
      ),
    );
  }
}
