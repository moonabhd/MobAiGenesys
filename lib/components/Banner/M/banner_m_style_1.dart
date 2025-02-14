import 'package:flutter/material.dart';
import 'banner_m.dart';

import '../../../constants.dart';

class BannerMStyle1 extends StatelessWidget {
  const BannerMStyle1({
    super.key,
    this.image = "assets/Illustration/header.png",
  });
  final String? image;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      children: const [
         Padding(
          padding:  EdgeInsets.all(defaultPadding),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
            ],
          ),
        ),
      ],
    );
  }
}
