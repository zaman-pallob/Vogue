import 'dart:convert';
import 'package:Vogue/Product/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Homegridview extends StatefulWidget {
  @override
  _HomegridviewState createState() => _HomegridviewState();
}

class _HomegridviewState extends State<Homegridview> {
  final String url = "http://103.146.54.151:9000/items";
  List item = [];
  List dp = [
    'products/p1.jpg',
    'products/p2.jpeg',
    'products/p4.jpg',
    'products/p3.jpg',
    'products/p7.jpg',
    'products/p6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convert = jsonDecode(response.body);
      item = convert;
    });
    return "Success";
  }

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
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ProductDetails(item[index]['name'],
                    item[index]['price'], item[index]['quantity'], dp[index])));
      },
      child: GridTile(
        footer: Container(
          width: 50,
          color: Colors.white70,
          child: ListTile(
            leading: Text(item[index]['name']),
            title: Text(
              "\u09F3" + item[index]['price'].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
            subtitle: Text(
              "N/A",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.green),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          child: Card(
            child: Image(
              image: AssetImage(dp[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
