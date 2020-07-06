import 'dart:convert';
import 'package:Vogue/Product/Items.dart';
import 'package:Vogue/Product/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Cart extends StatefulWidget {
  final List<String> prodname;
  final List<String> prodqty;
  final List<String> prodprice;
  Cart({this.prodname, this.prodqty, this.prodprice});

  @override
  _CartState createState() => _CartState();
}

Future<String> sendData(List<String> pN, List<String> pP, List<String> pQ,
    String name, String number) async {
  final String url = "http://103.146.54.151:9000/orders";
  List<Items> item = new List();

  for (int i = 0; i < pN.length; i++) {
    item.add(new Items(
        name: pN[i], quantity: int.parse(pQ[i]), price: int.parse(pP[i])));
  }
  Model object = new Model(name: name, number: number, items: item);
  var information = jsonEncode(object);

  var response = await http.post(url,
      headers: {'Content-type': 'application/json'}, body: information);

  if (response.statusCode == 201) {
    print("Success");
    return "success";
  } else {
    print("failed" + information);

    return "Failed";
  }
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.orangeAccent,
        title: Text("Vogue"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.clear_all), onPressed: () {})
        ],
      ),
      body: Container(child: singleBlock()),
      bottomNavigationBar: Container(
        child: bottom(),
      ),
    );
  }

  Widget singleBlock() {
    return ListView.builder(
        itemCount: widget.prodname.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Card(
              color: Colors.lightGreen,
              child: ListTile(
                leading: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    color: Colors.red,
                    onPressed: () {}),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.prodname[index]),
                    Text(widget.prodqty[index]),
                    Text(widget.prodprice[index]),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget bottom() {
    return Container(
        padding: EdgeInsets.all(5),
        color: Colors.orangeAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Total amount: " + totalcost()),
            RaisedButton(
                child: Text("Check Out"),
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ));
  }

  String totalcost() {
    int sum = 0;
    return sum.toString() + " \u09F3";
  }
}
