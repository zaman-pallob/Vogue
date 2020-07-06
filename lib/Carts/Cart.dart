import 'dart:convert';
import 'package:Vogue/Product/Constants.dart';
import 'package:Vogue/Product/Items.dart';
import 'package:Vogue/Product/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  final List<String> prodname;
  final List<String> prodqty;
  final List<String> prodprice;
  final String username;
  final String number;
  Cart(
      {this.prodname,
      this.prodqty,
      this.prodprice,
      this.username,
      this.number});

  @override
  _CartState createState() => _CartState();
}

Future<String> sendData(List<String> pN, List<String> pP, List<String> pQ,
    String name, String number) async {
  final String url = "http://103.146.54.151:9000/orders";
  List<Items> item = new List();
  int size = pN.length;
  for (int i = 0; i < size; i++) {
    item.add(new Items(
        name: pN[i], quantity: int.parse(pQ[i]), price: int.parse(pP[i])));
  }
  Model object = new Model(name: name, number: number, items: item);
  var information = jsonEncode(object);

  var response = await http.post(url,
      headers: {'Content-type': 'application/json'}, body: information);
  print(response.body);
  return response.body;
}

class _CartState extends State<Cart> {
  int sizes;
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
          IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                changeState();
              })
        ],
      ),
      body: Container(child: singleBlock()),
      bottomNavigationBar: Container(
        child: bottom(),
      ),
    );
  }

  changeState() {
    {
      setState(() {
        widget.prodname.clear();
        widget.prodprice.clear();
        widget.prodqty.clear();
        clearAll();
      });
    }
  }

  changeindividualState(int index) {
    {
      setState(() {
        widget.prodname.removeAt(index);
        widget.prodprice.removeAt(index);
        widget.prodqty.removeAt(index);
        removeSingle(widget.prodname, widget.prodqty, widget.prodprice);
      });
    }
  }

  Widget singleBlock() {
    if (widget.prodname == null) {
      return Text(
        "No items in cart",
        textAlign: TextAlign.center,
      );
    } else {
      return ListView.builder(
          itemCount: widget.prodname.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: Card(
                color: Colors.lightGreen,
                child: ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      color: Colors.red,
                      onPressed: () {
                        changeindividualState(index);
                      }),
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
                  sendData(widget.prodname, widget.prodprice, widget.prodqty,
                      widget.username, widget.number);
                  Navigator.pop(context);
                  changeState();
                })
          ],
        ));
  }

  String totalcost() {
    int sum = 0;
    if (widget.prodprice == null) {
      return "";
    } else {
      int size = widget.prodprice.length;
      for (int i = 0; i < size; i++) {
        sum += int.parse(widget.prodprice[i]);
      }
      return sum.toString() + " \u09F3";
    }
  }

  void clearAll() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(Constants.PRODUCT_NAME);
    pref.remove(Constants.PRODUCT_QUANTITY);
    pref.remove(Constants.PRODUCT_PRICE);
  }

  void removeSingle(
      List<String> prodnam, List<String> prodty, List<String> prodprec) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(Constants.PRODUCT_NAME, prodnam);
    pref.setStringList(Constants.PRODUCT_QUANTITY, prodty);
    pref.setStringList(Constants.PRODUCT_PRICE, prodprec);
  }
}
