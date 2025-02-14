import 'package:flutter/material.dart';
import 'package:shop/components/buy_full_ui_kit.dart';






class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return const AddressScreen();
  }
}

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find an address...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildAddNewAddressButton(context),
            const SizedBox(height: 20),
            _buildAddressList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewAddressButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to add new address screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddNewAddressScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        'Add new address',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildAddressList() {
    final List<Address> addresses = [
      Address(
        name: 'My home',
        address: 'Sophi Nowakowska, Zabiniec 12/222, 3I–215 Cracow, Poland',
        phone: '+79 123 456',
        additionalInfo: '789',
      ),
      Address(
        name: 'Office',
        address: 'Rio Nowakowska, Zabiniec 12/222, 3I–215 Cracow, Poland',
        phone: '+79 123 456',
        additionalInfo: '789',
      ),
      Address(
        name: 'Grandmother’s home',
        address: 'Rio Nowakowska, Zabiniec 12/222, 3I–215 Cracow, Poland',
        phone: '+79 123 456',
        additionalInfo: '789',
      ),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(address.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.address),
                Text(address.phone),
                if (address.additionalInfo.isNotEmpty)
                  Text(address.additionalInfo),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to edit address screen
              },
            ),
          ),
        );
      },
    );
  }
}

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name (e.g., Home, Office)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Additional Info',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the new address and navigate back
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Save Address',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Address {
  final String name;
  final String address;
  final String phone;
  final String additionalInfo;

  Address({
    required this.name,
    required this.address,
    required this.phone,
    this.additionalInfo = '',
  });
}