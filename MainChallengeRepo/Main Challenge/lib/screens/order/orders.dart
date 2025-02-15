import 'package:flutter/material.dart';

// Placeholder for product image URL
const String productDemoImg1 = 'https://via.placeholder.com/150';

// Define OrderItem class
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

// Define Order class
class Order {
  final String id;
  final DateTime placedDate;
  final List<OrderItem> items;
  String status;
  final double total;

  Order({
    required this.id,
    required this.placedDate,
    required this.items,
    required this.status,
    required this.total,
  });
}

// Placeholder for OrderDetailsScreen
class OrderDetailsScreen extends StatelessWidget {
  final String status;
  final List<Order> orders;
  final Function(Order, String) onStatusUpdate;

  const OrderDetailsScreen({
    required this.status,
    required this.orders,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - $status'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Order ID: ${order.id}'),
            subtitle: Text('Status: ${order.status}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showStatusUpdateDialog(context, order, onStatusUpdate);
              },
            ),
          );
        },
      ),
    );
  }

  void _showStatusUpdateDialog(BuildContext context, Order order, Function(Order, String) onStatusUpdate) {
    TextEditingController statusController = TextEditingController(text: order.status);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Order Status'),
          content: TextField(
            controller: statusController,
            decoration: InputDecoration(hintText: 'Enter new status'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onStatusUpdate(order, statusController.text);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();

  // List to store all orders
  final List<Order> _allOrders = [
    Order(
      id: "ORD001",
      placedDate: DateTime.now(),
      items: [
        OrderItem(
          id: "ITEM001",
          name: "It ends with us...",
          brand: "Agatha Christie",
          price: 299.43,
          originalPrice: 534.33,
          imageUrl: productDemoImg1,
        ),
      ],
      status: "Processing",
      total: 299.43,
    ),
    Order(
      id: "ORD002",
      placedDate: DateTime.now(),
      items: [
        OrderItem(
          id: "ITEM002",
          name: "It ends with us...",
          brand: "Agatha Christie",
          price: 299.43,
          originalPrice: 534.33,
          imageUrl: productDemoImg1,
        ),
      ],
      status: "Delivered",
      total: 299.43,
    ),
    Order(
      id: "ORD003",
      placedDate: DateTime.now(),
      items: [
        OrderItem(
          id: "ITEM003",
          name: "It ends with us...",
          brand: "Agatha Christie",
          price: 299.43,
          originalPrice: 534.33,
          imageUrl: productDemoImg1,
        ),
      ],
      status: "Returned",
      total: 299.43,
    ),
    Order(
      id: "ORD004",
      placedDate: DateTime.now(),
      items: [
        OrderItem(
          id: "ITEM004",
          name: "It ends with us...",
          brand: "Agatha Christie",
          price: 299.43,
          originalPrice: 534.33,
          imageUrl: productDemoImg1,
        ),
      ],
      status: "Canceled",
      total: 299.43,
    ),
    Order(
      id: "ORD005",
      placedDate: DateTime.now(),
      items: [
        OrderItem(
          id: "ITEM005",
          name: "It ends with us...",
          brand: "Agatha Christie",
          price: 299.43,
          originalPrice: 534.33,
          imageUrl: productDemoImg1,
        ),
      ],
      status: "Awaiting Payment",
      total: 299.43,
    ),
  ];

  List<Order> _filteredOrders = [];

  // Order counts map
  Map<String, int> orderCounts = {
    'Awaiting Payment': 0,
    'Processing': 0,
    'Delivered': 0,
    'Returned': 0,
    'Canceled': 0,
  };

  @override
  void initState() {
    super.initState();
    _filteredOrders = List.from(_allOrders); // Create a proper copy
    _updateOrderCounts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredOrders = _allOrders.where((order) {
        final matchesId = order.id.toLowerCase().contains(searchQuery);
        final matchesItems = order.items.any((item) =>
            item.name.toLowerCase().contains(searchQuery) ||
            item.brand.toLowerCase().contains(searchQuery));
        final matchesStatus = order.status.toLowerCase().contains(searchQuery);
        return matchesId || matchesItems || matchesStatus;
      }).toList();
      _updateOrderCounts();
    });
  }

  void _updateOrderCounts() {
    // Reset all counts
    orderCounts.updateAll((key, value) => 0);

    // Count orders by status
    for (var order in _filteredOrders) {
      if (orderCounts.containsKey(order.status)) {
        orderCounts[order.status] = (orderCounts[order.status] ?? 0) + 1;
      }
    }

    // Force UI update
    setState(() {});
  }

  void _updateOrderStatus(Order order, String newStatus) {
    setState(() {
      final index = _allOrders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        _allOrders[index] = Order(
          id: order.id,
          placedDate: order.placedDate,
          items: order.items,
          status: newStatus,
          total: order.total,
        );
        _filteredOrders = List.from(_allOrders); // Update filtered list
        _onSearchChanged(); // Apply current search filter
        _updateOrderCounts(); // Update the counts
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Orders', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Find an order...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged(); // Trigger search update when cleared
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Orders history',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_filteredOrders.length} orders',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          _buildOrderStatusList(),
        ],
      ),
    );
  }

  Widget _buildOrderStatusList() {
    return Expanded(
      child: ListView(
        children: [
          _buildOrderStatusTile(
            'Awaiting Payment',
            Icons.payment,
            Colors.amber,
            orderCounts['Awaiting Payment'] ?? 0,
          ),
          _buildOrderStatusTile(
            'Processing',
            Icons.inventory_2,
            Colors.blue,
            orderCounts['Processing'] ?? 0,
          ),
          _buildOrderStatusTile(
            'Delivered',
            Icons.local_shipping,
            Colors.green,
            orderCounts['Delivered'] ?? 0,
          ),
          _buildOrderStatusTile(
            'Returned',
            Icons.shopping_cart,
            Colors.orange,
            orderCounts['Returned'] ?? 0,
          ),
          _buildOrderStatusTile(
            'Canceled',
            Icons.cancel,
            Colors.red,
            orderCounts['Canceled'] ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusTile(String title, IconData icon, Color color, int count) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => _navigateToOrderDetails(title),
    );
  }

  void _navigateToOrderDetails(String status) {
    final filteredByStatus = _filteredOrders.where((order) => order.status == status).toList();
    if (filteredByStatus.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            status: status,
            orders: filteredByStatus,
            onStatusUpdate: _updateOrderStatus,
          ),
        ),
      );
    }
  }
}