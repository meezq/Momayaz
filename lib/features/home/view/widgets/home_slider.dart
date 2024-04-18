import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeSlider extends StatelessWidget {
  HomeSlider({super.key});

  final List<String> imgList = [
    'https://i.ibb.co/Xxj92Q3/pexels-mike-bird-112460.jpg',
    'https://i.ibb.co/SP6wv5D/pexels-aaron-curtis-119435.jpg',
    'https://i.ibb.co/yV91GJJ/image.png',
    'https://i.ibb.co/mNNSnJT/image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imgList.map((e) {
        return Card(
          shape: const RoundedRectangleBorder(),
          child: Align(
            alignment: Alignment.center,
            child: Image.network(
              e,
              width: double.infinity,
              height: 30.h,
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        height: 30.h,
        viewportFraction: 1,
      ),
    );
  }
}
