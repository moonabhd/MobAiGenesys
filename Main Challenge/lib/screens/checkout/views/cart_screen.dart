import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart'; // Ensure this import points to your constants file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoplon Cart',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Use demoCart as the cart items for demonstration
  List<BookModel> cartItems = demoCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display cart items dynamically
            ...cartBooks.map((product) => _buildCartItem(product)).toList(),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Type coupon code',
                prefixIcon: Icon(Icons.local_offer),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _buildOrderSummary(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodScreen(),
                  ),
                );
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BookModel product) {
    return Card(
      child: ListTile(
        onTap: (){Navigator.pushNamed(context, productDetailsScreenRoute,arguments: product);},
        leading: Image.network(
          product.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.title),
        subtitle: Text(product.author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (product.priceAfterDiscount != null)
              Text(
                '\$${product.priceAfterDiscount!.toStringAsFixed(2)}',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    double subtotal = cartItems.fold(0, (sum, product) => sum + product.price);
    double total = subtotal; // Add shipping fee or VAT if needed

    return Column(
      children: [
        const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
        _buildSummaryRow('Shipping Fee', 'Free'),
        _buildSummaryRow('Total (Include of VAT)', '\$${total.toStringAsFixed(2)}'),
        _buildSummaryRow('Estimated VAT', '\$1.00'), // Placeholder for VAT
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPaymentOption('Pay with card', Icons.credit_card, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCardScreen(),
                ),
              );
            }),
           
           
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Expiration Date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderConfirmationScreen(),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class CashPaymentScreen extends StatelessWidget {
  const CashPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with Cash'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('A Shoplon refundable \$24.00 will be charged to use cash on delivery.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderConfirmationScreen(),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditPaymentScreen extends StatelessWidget {
  const CreditPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Use Credit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Available Balance: \$1000'),
            const SizedBox(height: 16),
            const Text('Your Shoplon credit is not sufficient to pay for the order. Please select an additional payment method to cover the balance of \$500.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodScreen(),
                  ),
                );
              },
              child: const Text('Select Additional Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Thanks for your order', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('You’ll receive an email at **John.davids@gmail.com** once your order is confirmed.'),
            const SizedBox(height: 16),
            const Text('Order detail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildOrderDetailRow('Order number', '#FD5639820'),
            _buildOrderDetailRow('Amount paid', '\$400'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to track order screen
              },
              child: const Text('Track Order'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}


List<BookModel> demoCart = demoBestSellersBooks;