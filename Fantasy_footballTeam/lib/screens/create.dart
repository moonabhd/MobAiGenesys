import 'package:fantasy_football/screens/home_screen.dart';
import 'package:fantasy_football/screens/main_navigation_screen.dart';

import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  // Function to navigate to the HomeScreen
  void _navigateHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationScreen()), // Navigate to HomeScreen
    );
  }
    void _navigateToCreateAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to HomeScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 32, 34, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image in the center
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  image: DecorationImage(
                    image: AssetImage('assets/images/log.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title text
            
              const SizedBox(height: 16),
              // Create Account Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToCreateAccount(context); // Navigate to HomeScreen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1), // Greenish color for the button
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600, // Slightly bolder text for visibility
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Login Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateHome(context); // Navigate to HomeScreen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1), // Greenish color for the button
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 2, 2, 2),
                      fontWeight: FontWeight.w600, // Slightly bolder text for visibility
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Option to Skip or Go to Registration (optional)
            ],
          ),
        ),
      ),
    );
  }
}

