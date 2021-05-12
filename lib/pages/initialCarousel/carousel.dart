import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sigascript/pages/initialCarousel/first_carousel_screen.dart';
import 'package:sigascript/pages/initialCarousel/second_carousel_screen.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 500,
          child: Column(children: [
            CarouselSlider(
              items: [
                FirstScreen(),
                SecondScreen(),
              ],
              options: CarouselOptions(
                height: 400,
              ),
            ),
            SizedBox(height: 20),
            ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: 250,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Comece a usar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/loginPage');
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
