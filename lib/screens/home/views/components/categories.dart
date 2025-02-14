import 'package:flutter/material.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/home/views/components/popular_products.dart';
import '../../../../constants.dart';

class CategoryModel {
  final String name;

  CategoryModel({required this.name});
}

// List of categories
List<CategoryModel> demoCategories = [
  CategoryModel(name: "All Categories"),
  CategoryModel(name: "Novel"),
  CategoryModel(name: "Self-love"),
  CategoryModel(name: "Science"),
  CategoryModel(name: "Romance"),
  CategoryModel(name: "Crime"),
  CategoryModel(name: "Education"),
];

class Categories extends StatefulWidget {
  final Function(String) onCategorySelected;

  const Categories({
    super.key,
    required this.onCategorySelected,
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String _selectedCategory = "All Categories"; // Default category
  
  @override
  void initState() {
    super.initState();
    // Initialize with default category books
    categoryBook = List.from(demoBestSellersBooks);
  }
 
  // Function to update books based on category
  void updateCategoryBooks(String category) {
    setState(() {
      _selectedCategory = category;
      widget.onCategorySelected(category); // Notify parent about category change
      
      switch (category) {
        case "Novel":
          categoryBook = List.from(romanceBooks);
          break;
        case "Self-love":
          categoryBook = List.from(demoPopularBooks);
          break;
        case "Science":
          categoryBook = List.from(demoPopularBooks);
          break;
        case "Romance":
          categoryBook = List.from(romanceBooks);
          break;
        case "Crime":
          categoryBook = List.from(fictionBooks);
          break;
        case "Education":
          categoryBook = List.from(demoPopularBooks);
          break;
        default:
          categoryBook = List.from(demoBestSellersBooks);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Categories List
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoCategories.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? defaultPadding : defaultPadding / 2,
                    right: index == demoCategories.length - 1 ? defaultPadding : 0,
                  ),
                  child: CategoryBtn(
                    category: demoCategories[index].name,
                    isActive: _selectedCategory == demoCategories[index].name,
                    press: () {
                      updateCategoryBooks(demoCategories[index].name);
                      Navigator.pushNamed(context, discoverScreenRoute);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Display Books for Selected Category
        Expanded(
          child: ListView.builder(
            itemCount: categoryBook.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(categoryBook[index].title),
              // Add more product details as needed
              subtitle: Text(categoryBook[index].author),
              leading: Image.network(categoryBook[index].image),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryBtn extends StatelessWidget {
  final String category;
  final bool isActive;
  final VoidCallback press;

  const CategoryBtn({
    super.key,
    required this.category,
    required this.isActive,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? Colors.black12 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.black : const Color.fromRGBO(157, 157, 157, 1),
            ),
          ),
        ),
      ),
    );
  }
}