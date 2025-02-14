import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart';
import '../../../constants.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // While loading use 👇
          //  BookMarksSlelton(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final book = demoPopularBooks[index];
                  return Stack(
                    children: [
                      ProductCard(
                        image: book.image,
                        brandName: book.author,
                        title: book.title,
                        price: book.price,
                        priceAfetDiscount: book.priceAfterDiscount,
                        dicountpercent: book.discountPercent,
                        press: () {
                          Navigator.pushNamed(context, productDetailsScreenRoute);
                        },
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.purple),
                          onPressed: () {
                            // Navigate to edit screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookmarkScreen(
                                  book: book,
                                  onSave: (updatedBook) {
                                    // Update the bookmarked item
                                    demoPopularBooks[index] = updatedBook;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                childCount: demoPopularBooks.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditBookmarkScreen extends StatefulWidget {
  final BookModel book;
  final Function(BookModel) onSave;

  const EditBookmarkScreen({
    super.key,
    required this.book,
    required this.onSave,
  });

  @override
  State<EditBookmarkScreen> createState() => _EditBookmarkScreenState();
}

class _EditBookmarkScreenState extends State<EditBookmarkScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _priceController = TextEditingController(text: widget.book.price.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bookmark'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save the changes
              final updatedBook = BookModel(
                image: widget.book.image,
                title: _titleController.text,
                author: _authorController.text,
                publisher: widget.book.publisher,
                price: double.parse(_priceController.text),
                priceAfterDiscount: widget.book.priceAfterDiscount,
                discountPercent: widget.book.discountPercent,
                category:"romance",
                isbn: widget.book.isbn,
                inStock: widget.book.inStock,
              );
              widget.onSave(updatedBook);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}