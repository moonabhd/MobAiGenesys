import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import '../../../../route/route_constants.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/screen_export.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> recentSearches = [
    'Harry Potter',
    'Hopeless',
    'Fifty Shades of grey',
    'It start with us',
    'It ends with us',
  ];

  List<BookModel> searchResults = demoPopularBooks;
  List<BookModel> filteredResults = [];

  @override
  void initState() {
    super.initState();
    filteredResults = searchResults; // Initialize with all products
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredResults = searchResults; // Show all products if query is empty
      } else {
        filteredResults = searchResults
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      filteredResults = searchResults.where((product) {
        // Apply size filter
        if (filters['author'] != null && filters['author'] != product.author) {
          return false;
        }
        // Apply price filter
        if (filters['minPrice'] != null &&
            product.price < filters['minPrice']) {
          return false;
        }
        if (filters['maxPrice'] != null &&
            product.price > filters['maxPrice']) {
          return false;
        }
        // Apply in-stock filter
        if (filters['inStock'] == true && !product.inStock) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booki',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () async {
                      final filters = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilterScreen(),
                        ),
                      );
                      if (filters != null) {
                        _applyFilters(filters);
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                onChanged: (value) {
                  _filterProducts(value); // Filter products as the user types
                },
              ),
            ),
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildRecentSearches()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(color: Color(0xFF211613)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(recentSearches[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      recentSearches.removeAt(index); // Remove recent search
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Search result (${filteredResults.length} items)',
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
            itemCount: filteredResults.length,
            itemBuilder: (context, index) {
              return ProductCard(
                image: filteredResults[index].image,
                brandName: filteredResults[index].author,
                title: filteredResults[index].title,
                price: filteredResults[index].price,
                priceAfetDiscount: filteredResults[index].priceAfterDiscount,
                dicountpercent: filteredResults[index].discountPercent,
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

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedSize;
  double minPrice = 0;
  double maxPrice = 1000;
  bool inStock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Filter',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedSize = null;
                minPrice = 0;
                maxPrice = 1000;
                inStock = false;
              });
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Color(0xFF211613)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final filters = {
                        'author': selectedSize,
                        'minPrice': minPrice,
                        'maxPrice': maxPrice,
                        'inStock': inStock,
                      };
                      Navigator.pop(context, filters); // Return filters
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color(0xFF211613),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
          _buildFilterOption('author'),
          _buildFilterOption('Price'),
          CheckboxListTile(
            title: const Text('Available in stock'),
            value: inStock,
            onChanged: (value) {
              setState(() {
                inStock = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (title == 'author') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SizeFilterScreen(),
            ),
          ).then((value) {
            if (value != null) {
              setState(() {
                selectedSize = value;
              });
            }
          });
        } else if (title == 'Price') {
          // Navigate to price filter screen
        }
      },
    );
  }
}

class SizeFilterScreen extends StatefulWidget {
  const SizeFilterScreen({super.key});

  @override
  State<SizeFilterScreen> createState() => _SizeFilterScreenState();
}

class _SizeFilterScreenState extends State<SizeFilterScreen> {
  String? selectedSize;

  final List<Map<String, dynamic>> sizes = [
    {'author': 'Imen', 'count': 1},
    {'author': 'Zineb', 'count': 29},
    {'author': 'Maroua', 'count': 33},
    {'author': 'Hadj Melab', 'count': 32},
    {'author': 'Linus', 'count': 27},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'author',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedSize = null;
              });
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Color(0xFF211613)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                final size = sizes[index];
                return RadioListTile<String>(
                  title: Text('${size['author']} (${size['count']})'),
                  value: size['author'],
                  groupValue: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedSize); // Return selected size
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF211613),
                ),
                child: const Text('Done'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}