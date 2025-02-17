import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';

import '../../../../constants.dart';
import '../../../../route/route_constants.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({
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
            "Best Selling Products",
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
        // const ProductsSkelton(),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoBestSellersBooks on models/ProductModel.dart
            itemCount: demoBestSellersBooks.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == demoBestSellersBooks.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: demoBestSellersBooks[index].image,
                brandName: demoBestSellersBooks[index].title,
                title: demoBestSellersBooks[index].title,
                price: demoBestSellersBooks[index].price,
                priceAfetDiscount:
                    demoBestSellersBooks[index].priceAfterDiscount,
                dicountpercent: demoBestSellersBooks[index].discountPercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: demoBestSellersBooks[index]);
                },
              ),
            ),
          ),
        ),
       
      ],
    );
  }
}
