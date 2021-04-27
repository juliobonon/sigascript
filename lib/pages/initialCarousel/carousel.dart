import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sigascript/pages/initialCarousel/learnAboutSiga.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          child: CarouselSlider(
            items: [LearnAboutSiga()],
            options: CarouselOptions(
              height: 400,
            ),
          ),
        ),
      ),
    );
  }
}
