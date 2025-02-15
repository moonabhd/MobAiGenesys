import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/search/views/components/search_form.dart';



class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Close the screen
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Search result (${categoryBook.length} items)',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categoryBook.length,
            itemBuilder: (context, index) {
              return ProductCard(
                image: categoryBook[index].image,
                brandName: categoryBook[index].author,
                title: categoryBook[index].title,
                price: categoryBook[index].price,
                priceAfetDiscount: categoryBook[index].priceAfterDiscount,
                dicountpercent: categoryBook[index].discountPercent,
                press: () {
                  Navigator.pushNamed(context, productDetailsScreenRoute);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
