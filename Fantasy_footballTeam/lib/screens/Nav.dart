import 'package:flutter/material.dart';

class OnboardingPages extends StatefulWidget {
  @override
  _OnboardingPagesState createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  // PageController to control the pages and provide animations
  final PageController _pageController = PageController();
  int currentPage = 0;

  // A function to move to the next page
  void _nextPage() {
    if (currentPage < 2) {
      _pageController.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: [
          _buildPage(
            image: 'assets/images/intro1.png',
            title: 'Welcome to Fantasy Football',
            description: 'Create your team and start your fantasy league experience!',
          ),
          _buildPage(
            image: 'assets/images/player.png',
            title: 'Build Your Dream Team',
            description: 'Choose the best players and manage your team to win!',
          ),
          _buildPage(
            image: 'assets/images/intro3.png',
            title: 'Join the Market',
            description: 'Trade players, earn points, and compete for the top spot.',
          ),
        ],
      ),
    );
  }

  Widget _buildPage({required String image, required String title, required String description}) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Column(
        key: ValueKey<int>(currentPage),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: Image.asset(
              image,
              height: 100,
            ),
          ),
          SizedBox(height: 30),
          // Title
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 500),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(61, 147, 19, 100),
            ),
            child: Text(title),
          ),
          SizedBox(height: 15),
          // Description
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 500),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          // Next button
          ElevatedButton(
            onPressed: _nextPage,
            child: Text(currentPage == 2 ? 'Get Started' : 'Next'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
