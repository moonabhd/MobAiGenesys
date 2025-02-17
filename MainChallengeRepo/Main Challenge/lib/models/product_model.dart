import 'package:flutter/material.dart';
import 'package:shop/constants.dart'; // Ensure this import points to your constants file

class BookModel {
  final String image, title, author, publisher;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent;
  final double isbn;
  final String category;
  final bool inStock;

  BookModel({
    required this.image,
    required this.title,
    required this.author,
    required this.publisher,
    required this.price,
    this.priceAfterDiscount,
    this.discountPercent,
    required this.isbn,
    required this.category,
    required this.inStock,
  });
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'],
      author: json['author'],
      price: json['price'],
      image: productDemoImg1,
      inStock: true,
      publisher:"unknown",
      isbn:json['rating'],
      category:json['mood']
    );
  }
}
List<BookModel> categoryBook=[...romanceBooks];

// Romance Books
List<BookModel> romanceBooks = [
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "The Notebook",
    author: "Nicholas Sparks",
    publisher: "Grand Central Publishing",
    price: 12.99,
    priceAfterDiscount: 9.99,
    discountPercent: 25,
    isbn: 9.8,
    category: "Romance",
    inStock: true,
  ),
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "Pride and Prejudice",
    author: "Jane Austen",
    publisher: "T. Egerton, Whitehall",
    price: 10.99,
    priceAfterDiscount: 8.99,
    discountPercent: 10,
    isbn: 3.8,
    category: "Romance",
    inStock: true,
  ),
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "Me Before You",
    author: "Jojo Moyes",
    publisher: "Penguin Books",
    price: 14.99,
    priceAfterDiscount: 12.99,
    discountPercent: 15,
    isbn: 9.8,
    category: "Romance",
    inStock: true,
  ),
];

// Fiction Books
List<BookModel> fictionBooks = [
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "The Alchemist",
    author: "Paulo Coelho",
    publisher: "HarperOne",
    price: 15.99,
    priceAfterDiscount: 12.99,
    discountPercent: 20,
    isbn: 9.8,
    category: "Fiction",
    inStock: true,
  ),
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "The Da Vinci Code",
    author: "Dan Brown",
    publisher: "Doubleday",
    price: 16.99,
    priceAfterDiscount: 14.99,
    discountPercent: 10,
    isbn: 9.8,
    category: "Fiction",
    inStock: true,
  ),
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "The Kite Runner",
    author: "Khaled Hosseini",
    publisher: "Riverhead Books",
    price: 13.99,
    priceAfterDiscount: 10.99,
    discountPercent: 20,
    isbn: 9.8,
    category: "Fiction",
    inStock: true,
  ),
];

// Combined Lists
List<BookModel> demoPopularBooks = [
  ...romanceBooks,
  ...fictionBooks,
];

List<BookModel> demoFlashSaleBooks = [
  ...romanceBooks,
  ...fictionBooks,
];

List<BookModel> demoBestSellersBooks = [
  ...romanceBooks,
  ...fictionBooks,
];

List<BookModel> kidsBooks = [
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "Harry Potter and the Philosopher's Stone",
    author: "J.K. Rowling",
    publisher: "Bloomsbury",
    price: 19.99,
    priceAfterDiscount: 17.99,
    discountPercent: 10,
    isbn: 9.8,
    category: "Kids",
    inStock: true,
  ),
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "The Lion, the Witch and the Wardrobe",
    author: "C.S. Lewis",
    publisher: "Geoffrey Bles",
    price: 14.99,
    priceAfterDiscount: 12.99,
    discountPercent: 15,
    isbn: 9.8,
    category: "Kids",
    inStock: true,
  ),
  BookModel(
    image: "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
    title: "Charlotte's Web",
    author: "E.B. White",
    publisher: "Harper & Brothers",
    price: 12.99,
    priceAfterDiscount: 10.99,
    discountPercent: 20,
    isbn: 9.8,
    category: "Kids",
    inStock: true,
  ),
];
List<BookModel> demoSavedBooks=demoPopularBooks;
List<BookModel> recentSearchdemo=demoPopularBooks;
List<BookModel> cartBooks=[demoPopularBooks[0]];