import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/views/welcome.dart';

import 'components/onbording_content.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Onbord> _onbordData = [
    Onbord(
      image: "assets/Illustration/BookLogo.png",
      imageDarkTheme: "assets/Illustration/BookLogo.png",
    ),
  ];
  Timer? _timer;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _startTimer(); // Start the timer for automatic transitions
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageIndex < _onbordData.length - 1) {
        _pageController.nextPage(
          curve: Curves.ease,
          duration: defaultDuration,
        );
      } else {
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    _timer?.cancel(); // Cancel the timer before navigating
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const WelcomePage(), // Replace with your next screen
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: defaultDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onbordData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return AnimatedSwitcher(
                      duration: defaultDuration,
                      child: OnbordingContent(
                        key: ValueKey(index), // Unique key for each page
                        image: (Theme.of(context).brightness == Brightness.dark &&
                                _onbordData[index].imageDarkTheme != null)
                            ? _onbordData[index].imageDarkTheme!
                            : _onbordData[index].image,
                      ),
                    );
                  },
                ),
              ),
              // Remove the arrow button
            ],
          ),
        ),
      ),
    );
  }
}

class Onbord {
  final String image;
  final String? imageDarkTheme;

  Onbord({
    required this.image,
    this.imageDarkTheme,
  });
}