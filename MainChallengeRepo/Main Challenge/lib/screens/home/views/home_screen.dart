import 'package:flutter/material.dart';
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
