import 'dart:convert';

import 'package:Vogue/Carts/CartItems.dart';
import 'package:Vogue/Product/Items.dart';
import 'package:Vogue/Product/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Cart extends StatefulWidget {
  final CartItems cartitems;
  Cart(this.cartitems);

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
  List<String> pName = new List();
  List<String> pPrice = new List();
  List<String> pQty = new List();

  @override
  Widget build(BuildContext context) {
    pName = widget.cartitems.getProdname();
    pPrice = widget.cartitems.getProdprice();
    pQty = widget.cartitems.getProdqty();
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
          IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                widget.cartitems.clearAll();
                changeText();
              })
        ],
      ),
      body: Container(child: singleBlock()),
      bottomNavigationBar: Container(
        child: bottom(),
      ),
    );
  }

  changeSingle(String name, String prc, String qt) {
    setState(() {
      pName.remove(name);
      pPrice.remove(prc);
      pQty.remove(qt);
    });
  }

  changeText() {
    setState(() {
      for (int i = 0; i <= pName.length; i++) {
        pName.removeAt(i);
        pPrice.removeAt(i);
        pQty.removeAt(i);
      }
    });
  }

  Widget singleBlock() {
    return ListView.builder(
        itemCount: pName.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Card(
              color: Colors.lightGreen,
              child: ListTile(
                leading: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    color: Colors.red,
                    onPressed: () {
                      widget.cartitems.clearSelected(
                          pName[index], pQty[index], pPrice[index]);
                      changeSingle(pName[index], pPrice[index], pQty[index]);
                    }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(pName[index]),
                    Text(pQty[index]),
                    Text(pPrice[index]),
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
                onPressed: () async {
                  await sendData(pName, pPrice, pQty, widget.cartitems.username,
                      widget.cartitems.number);
                  Navigator.pop(context);
                  widget.cartitems.clearAll();
                })
          ],
        ));
  }

  String totalcost() {
    int sum = 0;
    for (int i = 0; i < pPrice.length; i++) {
      sum += int.parse(pPrice[i]);
    }

    return sum.toString() + " \u09F3";
  }
}
