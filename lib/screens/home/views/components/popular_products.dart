import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/screen_export.dart';
import '../../../../constants.dart';

class PopularProducts extends StatelessWidget {
  final String? category;

  const PopularProducts({
    super.key,
    this.category,
  });

  List<BookModel> getFilteredProducts() {
    if (category == null || category!.isEmpty) {
      return demoPopularBooks;
    }

    return demoPopularBooks.where((book) {
      // Case-insensitive category matching
      return book.category.toLowerCase() == category!.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = getFilteredProducts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        SizedBox(
          height: 300,
          child: filteredBooks.isEmpty
              ? Center(
                  child: Text(
                    'No books found in ${category ?? ""} category',
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredBooks.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == filteredBooks.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                      image: filteredBooks[index].image,
                      brandName: filteredBooks[index].author,
                      title: filteredBooks[index].title,
                      price: filteredBooks[index].price,
                      priceAfetDiscount: filteredBooks[index].priceAfterDiscount,
                      dicountpercent: filteredBooks[index].discountPercent,
                      press: () {
                        Navigator.pushNamed(
                          context,
                          productDetailsScreenRoute,
                          arguments: index.isEven,
                        );
                      },
                    ),
                  ),
                ),
        )
      ],
    );
  }
}