import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Carousel(
      boxFit: BoxFit.fill,
      images: [
        AssetImage('images/f.jpg'),
        AssetImage('images/f1.jpg'),
        AssetImage('images/f2.jpg'),
        AssetImage('images/f3.jpg'),
        AssetImage('images/f4.jpg'),
        AssetImage('images/f5.jpg'),
        AssetImage('images/f6.jpg'),
        AssetImage('images/f7.jpg'),
        AssetImage('images/f8.jpg'),
        AssetImage('images/f9.jpg'),
      ],
      autoplay: true,
      dotSize: 5.0,
      dotBgColor: Colors.transparent,
      dotIncreasedColor: Colors.greenAccent,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
    );
  }
}
