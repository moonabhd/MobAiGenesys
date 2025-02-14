import 'package:flutter/material.dart';
import 'package:shop/constants.dart'; // Ensure this import points to your constants file

class BookModel {
  final String image, title, author, publisher;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent;
  final String isbn;
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
}
List<BookModel> categoryBook=[...romanceBooks];

// Romance Books
List<BookModel> romanceBooks = [
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "The Notebook",
    author: "Nicholas Sparks",
    publisher: "Grand Central Publishing",
    price: 12.99,
    priceAfterDiscount: 9.99,
    discountPercent: 25,
    isbn: "9781455582877",
    category: "Romance",
    inStock: true,
  ),
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "Pride and Prejudice",
    author: "Jane Austen",
    publisher: "T. Egerton, Whitehall",
    price: 10.99,
    priceAfterDiscount: 8.99,
    discountPercent: 10,
    isbn: "9780141439518",
    category: "Romance",
    inStock: true,
  ),
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "Me Before You",
    author: "Jojo Moyes",
    publisher: "Penguin Books",
    price: 14.99,
    priceAfterDiscount: 12.99,
    discountPercent: 15,
    isbn: "9780718157838",
    category: "Romance",
    inStock: true,
  ),
];

// Fiction Books
List<BookModel> fictionBooks = [
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "The Alchemist",
    author: "Paulo Coelho",
    publisher: "HarperOne",
    price: 15.99,
    priceAfterDiscount: 12.99,
    discountPercent: 20,
    isbn: "9780062315007",
    category: "Fiction",
    inStock: true,
  ),
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "The Da Vinci Code",
    author: "Dan Brown",
    publisher: "Doubleday",
    price: 16.99,
    priceAfterDiscount: 14.99,
    discountPercent: 10,
    isbn: "9780307474278",
    category: "Fiction",
    inStock: true,
  ),
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "The Kite Runner",
    author: "Khaled Hosseini",
    publisher: "Riverhead Books",
    price: 13.99,
    priceAfterDiscount: 10.99,
    discountPercent: 20,
    isbn: "9781594631931",
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
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "Harry Potter and the Philosopher's Stone",
    author: "J.K. Rowling",
    publisher: "Bloomsbury",
    price: 19.99,
    priceAfterDiscount: 17.99,
    discountPercent: 10,
    isbn: "9780747532743",
    category: "Kids",
    inStock: true,
  ),
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "The Lion, the Witch and the Wardrobe",
    author: "C.S. Lewis",
    publisher: "Geoffrey Bles",
    price: 14.99,
    priceAfterDiscount: 12.99,
    discountPercent: 15,
    isbn: "9780060234812",
    category: "Kids",
    inStock: true,
  ),
  BookModel(
    image: "https://www.baylanguagebooks.co.uk/cdn/shop/products/9789600122855_800x.jpg?v=1733147836",
    title: "Charlotte's Web",
    author: "E.B. White",
    publisher: "Harper & Brothers",
    price: 12.99,
    priceAfterDiscount: 10.99,
    discountPercent: 20,
    isbn: "9780061124952",
    category: "Kids",
    inStock: true,
  ),
];