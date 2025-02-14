import 'package:flutter/material.dart';
import 'package:shop/components/Banner/S/banner_s_style_1.dart';
import 'package:shop/components/Banner/S/banner_s_style_5.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/screen_export.dart';
import 'components/best_sellers.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
             SliverToBoxAdapter(child: OffersCarouselAndCategories()),
             SliverToBoxAdapter(child: MostPopular()),   
             SliverToBoxAdapter(child: BestSellers()),   
            
          ],
        ),
      ),
    );
  }
}
