import 'package:flutter/material.dart';
import 'package:shop/route/route_constants.dart';

import '/components/Banner/M/banner_m_with_counter.dart';
import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading show 👇
        // const BannerMWithCounterSkelton(),
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          text: "Super Flash Sale \n50% Off",
          press: () {},
        ),
        const SizedBox(height: defaultPadding / 2),
        const Padding(
           padding:  EdgeInsets.all(defaultPadding),
          child:  Center(
  child: Text(
    "Flash Books",
    style: TextStyle(
      fontSize: 20, // Increase font size
      fontWeight: FontWeight.bold, // Make text bolder
      color: Colors.white, // Text color
    ),
    textAlign: TextAlign.center, // Ensure text is centered
  ),
),
        ),
        // While loading show 👇
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoFlashSaleBooks on models/ProductModel.dart
            itemCount: demoFlashSaleBooks.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == demoFlashSaleBooks.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: demoFlashSaleBooks[index].image,
                brandName: demoFlashSaleBooks[index].author,
                title: demoFlashSaleBooks[index].title,
                price: demoFlashSaleBooks[index].price,
                priceAfetDiscount:
                    demoFlashSaleBooks[index].priceAfterDiscount,
                dicountpercent: demoFlashSaleBooks[index].discountPercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute,
                      arguments: index.isEven);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
