import 'package:Vogue/Home/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

final pages = {
  '/home': (BuildContext context) => new Home(),
  '/': (BuildContext context) => new Home(),
};

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: pages,
    );
  }
}
