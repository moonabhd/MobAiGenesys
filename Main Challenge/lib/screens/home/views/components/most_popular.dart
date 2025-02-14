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
          padding:  EdgeInsets.all(defaultPadding),
          child:  Center(
  child: Text(
    "Most Popular Books",
    style: TextStyle(
      fontSize: 20, // Increase font size
      fontWeight: FontWeight.bold, // Make text bolder
      color: Colors.white, // Text color
    ),
    textAlign: TextAlign.center, // Ensure text is centered
  ),
),
        ),
        // While loading use 👇
        // SeconderyProductsSkelton(),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoPopularBooks on models/ProductModel.dart
            itemCount: demoPopularBooks.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == demoPopularBooks.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: SecondaryProductCard(
                image: demoPopularBooks[index].image,
                brandName: demoPopularBooks[index].author,
                title: demoPopularBooks[index].title,
                price: demoPopularBooks[index].price,
                priceAfetDiscount: demoPopularBooks[index].priceAfterDiscount,
                dicountpercent: demoPopularBooks[index].discountPercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: index.isEven);
                },
              ),
            ),
          ),
        )
        
      ],
    
    );
  }
}
