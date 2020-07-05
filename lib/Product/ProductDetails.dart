import 'dart:convert';
import 'dart:js';

import 'package:Vogue/Product/Items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ProductDetails extends StatefulWidget {
  final String name;
  final int price;
  final int quantity;
  final String dp;

  ProductDetails(this.name, this.price, this.quantity, this.dp);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

Future<String> sendData(String name, int price, int qty) async {
  final String url = "http://103.146.54.151:9000/orders";
  List<Map> cartitems = new List();
  Items item = new Items(name, qty, price);
  cartitems.add(item.tojsonData());
  var information = jsonEncode({"items": cartitems});
  var response = await http.post(url,
      headers: {'Content-type': 'application/json'}, body: information);
  if (response.statusCode == 201) {
    return "Success";
  } else {
    return "Failed";
  }
}

class _ProductDetailsState extends State<ProductDetails> {
  int amount = 1;

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
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            //product details container
            child: GridTile(
              footer: Container(
                height: 50,
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.name),
                  title: Expanded(
                    child: Text(
                      "\u09F3" + widget.price.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ),
                ),
              ),
              child: Container(
                child: Card(
                  child: Image(
                    image: AssetImage(widget.dp),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Size"),
                      ),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Color"),
                      ),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Choose Quantity",
                              textAlign: TextAlign.center,
                            ),
                            content: sizeBlock(widget.quantity),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Close",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Qty"),
                      ),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                )),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Text(
                "Total Selected :" + '$amount'.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            //button container
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("Buy Now"),
                    color: Colors.redAccent,
                    highlightColor: Colors.green,
                    onPressed: () async {
                      await sendData(
                          widget.name, widget.price * amount, amount);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.green,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            //details container;
            child: ListTile(
              title: Text("Details"),
              subtitle: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
            ),
          ),
        ],
      ),
    );
  }

  Widget sizeBlock(int limit) {
    return Center(
      child: ListView.builder(
          itemCount: limit,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                changeText(index);
                Navigator.pop(context);
              },
              title: Text(
                (index + 1).toString(),
                textAlign: TextAlign.center,
              ),
            );
          }),
    );
  }

  changeText(int index) {
    setState(() {
      amount = index + 1;
    });
  }
}
