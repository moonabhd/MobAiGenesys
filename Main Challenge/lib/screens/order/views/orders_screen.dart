import 'package:flutter/material.dart';
import 'package:shop/components/buy_full_ui_kit.dart';
import 'package:shop/constants.dart';
import 'package:shop/screens/order/orders.dart';


class OrderItem {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double originalPrice;
  final String imageUrl;

  OrderItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
  });
}
class Order {
  final String id;
  final DateTime placedDate;
  final List<OrderItem> items;
  final String status;
  final double total;

  Order({
    required this.id,
    required this.placedDate,
    required this.items,
    required this.status,
    required this.total,
  });
}


class OrderDetailsScreen extends StatefulWidget {
  final String status;
  final List<Order> orders;
  final Function(Order, String) onStatusUpdate;

  const OrderDetailsScreen({
    Key? key,
    required this.status,
    required this.orders,
    required this.onStatusUpdate,
  }) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? selectedReason;
  late Order currentOrder;
  final List<String> cancellationReasons = [
    "It's too costly.",
    "I found another product that fulfills my need.",
    "I don't use it enough.",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
    currentOrder = widget.orders.first; // You might want to add navigation between multiple orders
  }

  // Calculate progress based on status
  int _getProgressIndex(String status) {
    final stages = ['Ordered', 'Processing', 'Packed', 'Shipped', 'Delivered'];
    switch (status) {
      case 'Awaiting Payment':
        return 0;
      case 'Processing':
        return 1;
      case 'Packed':
        return 2;
      case 'Shipped':
        return 3;
      case 'Delivered':
        return 4;
      default:
        return 0;
    }
  }

  void _handleStatusUpdate(String newStatus) {
    widget.onStatusUpdate(currentOrder, newStatus);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool canCancel = currentOrder.status != 'Delivered' && 
                          currentOrder.status != 'Canceled' &&
                          currentOrder.status != 'Returned';
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          canCancel ? 'Cancel order' : 'Order details',
          style: const TextStyle(color: Colors.black)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {
              _showOrderInfo(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(),
            _buildOrderProgress(),
            _buildOrderItems(),
            if (canCancel) _buildCancellationReason(),
            const SizedBox(height: 20),
            if (canCancel) _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order #${currentOrder.id}'),
          const SizedBox(height: 8),
          Text(
            'Placed on ${currentOrder.placedDate.toString().split(' ')[0]}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: ${currentOrder.status}',
            style: TextStyle(
              fontSize: 16,
              color: _getStatusColor(currentOrder.status),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Awaiting Payment':
        return Colors.amber;
      case 'Processing':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Returned':
        return Colors.orange;
      case 'Canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildOrderProgress() {
    final int currentProgress = _getProgressIndex(currentOrder.status);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProgressItem('Ordered', 0 <= currentProgress),
          _buildProgressItem('Processing', 1 <= currentProgress),
          _buildProgressItem('Packed', 2 <= currentProgress),
          _buildProgressItem('Shipped', 3 <= currentProgress),
          _buildProgressItem('Delivered', 4 <= currentProgress),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String label, bool isCompleted) {
    return Column(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isCompleted ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems() {
    return Column(
      children: currentOrder.items.map((item) => 
        _buildOrderItem(
          item.name,
          item.brand,
          item.price,
          item.originalPrice,
          item.imageUrl,
        ),
      ).toList(),
    );
  }

  Widget _buildOrderItem(String name, String brand, double price, double originalPrice, String image) {
    return ListTile(
      leading: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(brand),
          Row(
            children: [
              Text(
                '\$$price',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$$originalPrice',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationReason() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is the biggest reason for your wish to cancel?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ...cancellationReasons.map((reason) => _buildReasonRadio(reason)).toList(),
        ],
      ),
    );
  }

  Widget _buildReasonRadio(String reason) {
    return RadioListTile<String>(
      title: Text(reason),
      value: reason,
      groupValue: selectedReason,
      onChanged: (value) {
        setState(() {
          selectedReason = value;
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Keep Order'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: selectedReason != null
                  ? () => _handleStatusUpdate('Canceled')
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Cancel Order'),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${currentOrder.id}'),
            Text('Status: ${currentOrder.status}'),
            Text('Total Amount: \$${currentOrder.total.toStringAsFixed(2)}'),
            Text('Items: ${currentOrder.items.length}'),
            Text('Order Date: ${currentOrder.placedDate.toString().split(' ')[0]}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
