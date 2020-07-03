import 'package:flutter/material.dart';

class Homegridview extends StatefulWidget {
  @override
  _HomegridviewState createState() => _HomegridviewState();
}

class _HomegridviewState extends State<Homegridview> {
  List item = [
    {
      'name': 'Blazer-101',
      'price': '800\$',
      'discount': '10 %',
      'dp': 'products/p1.jpg'
    },
    {
      'name': 'Casual Shirt',
      'price': '300\$',
      'discount': '4 %',
      'dp': 'products/p2.jpeg'
    },
    {
      'name': 'Blue Hill',
      'price': '200\$',
      'discount': '0 %',
      'dp': 'products/p3.jpg'
    },
    {
      'name': 'Blazers-23',
      'price': '700\$',
      'discount': '15 %',
      'dp': 'products/p4.jpg'
    },
    {
      'name': 'Blazer-111',
      'price': '800\$',
      'discount': '6 %',
      'dp': 'products/p5.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: item.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return singleBlock(index, item);
        });
  }

  Widget singleBlock(int index, List item) {
    return InkWell(
      onTap: () {},
      child: GridTile(
        header: ListTile(
          leading: Text(
            item[index]['name'],
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          title: Text(
            "Price:" + item[index]['price'],
            style: TextStyle(
              fontSize: 13,
              color: Colors.redAccent,
            ),
          ),
          subtitle: Text(
            "Dis: " + item[index]['discount'],
            style: TextStyle(
              fontSize: 13,
              color: Colors.redAccent,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          child: Card(
            child: Image(
              image: AssetImage(item[index]['dp']),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
