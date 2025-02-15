import 'package:flutter/material.dart';


class OnbordingContent extends StatelessWidget {
  const OnbordingContent({
    super.key,
    required this.image,
  });

  
  final String  image;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        const Spacer(),

       
        /// if you are using SVG then replace [Image.asset] with [SvgPicture.asset]

        Image.asset(
          image,
          height: 400,
        ),
       
        const Spacer(),
      ],
    );
  }
}

class OnbordTitleDescription extends StatelessWidget {
  const OnbordTitleDescription({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
      ],
    );
  }
}
