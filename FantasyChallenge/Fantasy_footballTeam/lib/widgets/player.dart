import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final String image;
  final String name;
  final String position;
  final double top;
  final double right;
  final double left;
  final VoidCallback? onTap;

  const PlayerWidget({
    required this.image,
    required this.name,
    required this.position,
    required this.top,
    required this.right,
    required this.left,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(
              image,
              height: 40,
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              position,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
