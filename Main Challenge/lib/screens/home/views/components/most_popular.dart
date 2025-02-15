import 'package:flutter/material.dart';
import 'package:shop/components/product/secondary_product_card.dart';
import 'package:shop/models/product_model.dart';

import '../../../../constants.dart';
import '../../../../route/route_constants.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        const Padding(
        padding: const EdgeInsets.symmetric(vertical: 10), // Adds vertical padding
        child: const Center(
          child: Text(
            "Recommended Books",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold, // Make it bold
              color: purpleColor, // Change text color
              
            ),
          ),
        ),
      ),    
        // While loading use 👇
        // SeconderyProductsSkelton(),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find recentSearchdemo on models/ProductModel.dart
            itemCount: recentSearchdemo.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == recentSearchdemo.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: SecondaryProductCard(
                image: recentSearchdemo[index].image,
                brandName: recentSearchdemo[index].author,
                title: recentSearchdemo[index].title,
                price: recentSearchdemo[index].price,
                priceAfetDiscount: recentSearchdemo[index].priceAfterDiscount,
                dicountpercent: recentSearchdemo[index].discountPercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: recentSearchdemo[index]);
                },
              ),
            ),
          ),
        )
        
      ],
    
    );
  }
}
