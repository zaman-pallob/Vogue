import 'package:Vogue/Login/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

final pages = {
  '/': (BuildContext context) => new Login(),
};

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: pages,
    );
  }
}
