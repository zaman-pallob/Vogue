import 'package:Vogue/Carts/Cart.dart';
import 'package:Vogue/Product/Constants.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final int price;
  final int quantity;
  final String dp;
  final String username, number;

  ProductDetails(this.name, this.price, this.quantity, this.dp, this.username,
      this.number);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int amount = 1;
  bool isAdded = false;
  String username;
  String number;
  List<String> prodname = new List();
  List<String> prodprice = new List();
  List<String> prodqty = new List();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            onPressed: () {
              getData();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Cart(
                            prodname: prodname,
                            prodqty: prodqty,
                            prodprice: prodprice,
                            username: username,
                            number: number,
                          )));
            },
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
                  title: Text(
                    "\u09F3" + widget.price.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.greenAccent),
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
            child: Text(
              "Total Selected :" + '$amount'.toString(),
              textAlign: TextAlign.center,
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
                    onPressed: () {
                      getData();
                      if (!isAdded) {
                        save(widget.name, widget.price, amount);
                      }

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Cart(
                                    prodname: prodname,
                                    prodqty: prodqty,
                                    prodprice: prodprice,
                                    username: username,
                                    number: number,
                                  )));
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.green,
                  onPressed: () {
                    if (!isAdded) {
                      isAdded = true;
                      save(widget.name, widget.price, amount);
                    } else {
                      toast();
                    }
                  },
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

  void toast() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Already Added to the cart",
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
    ));
  }

  void getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    prodname = pref.getStringList(Constants.PRODUCT_NAME);
    prodqty = pref.getStringList(Constants.PRODUCT_QUANTITY);
    prodprice = pref.getStringList(Constants.PRODUCT_PRICE);
  }

  void save(String name, int price, int quantity) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    prodname = pref.getStringList(Constants.PRODUCT_NAME);
    prodqty = pref.getStringList(Constants.PRODUCT_QUANTITY);
    prodprice = pref.getStringList(Constants.PRODUCT_PRICE);
    if (prodname == null) {
      prodname = new List();
      prodprice = new List();
      prodqty = new List();
    }
    prodname.add(name);
    prodprice.add((quantity * price).toString());
    prodqty.add(quantity.toString());
    pref.setStringList(Constants.PRODUCT_NAME, prodname);
    pref.setStringList(Constants.PRODUCT_QUANTITY, prodqty);
    pref.setStringList(Constants.PRODUCT_PRICE, prodprice);
  }
}
