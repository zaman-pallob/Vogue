import 'package:Vogue/Carts/Cart.dart';
import 'package:Vogue/Home/HomeSlider.dart';
import 'package:Vogue/Home/Homegridview.dart';
import 'package:Vogue/Home/HorizontalList.dart';
import 'package:Vogue/Product/Constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String username, number;

  Home(this.username, this.number);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> prodname = new List();
  List<String> prodprice = new List();
  List<String> prodqty = new List();

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Vogue"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Cart(
                          prodname: prodname,
                          prodqty: prodqty,
                          prodprice: prodprice)));
            },
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          drawerHeader("Atikur Zaman Pallob", "atikurzamanpallob@gmail.com",
              Icons.account_circle),
          drawerOptions("Homepage", Icons.home),
          drawerOptions("MyAccount", Icons.account_box),
          drawerOptions("Dashboard", Icons.dashboard),
          drawerOptions("Myorders", Icons.shopping_basket),
          drawerOptions("Categories", Icons.category),
          drawerOptions("Favourites", Icons.favorite),
          drawerOptions("Settings", Icons.settings),
          drawerOptions("About", Icons.info),
        ],
      )),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: HomeSlider(),
          ),
          Container(
            padding: EdgeInsets.all(2),
            child: Text(
              "Categories",
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: HorizontalList(),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Homegridview(),
          )
        ],
      ),
    );
  }

  Widget drawerHeader(String name, String email, IconData icons) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.orangeAccent),
      accountName: Text(widget.username),
      accountEmail: Text(widget.number),
      currentAccountPicture: new CircleAvatar(
        child: Icon(icons),
      ),
    );
  }

  Widget drawerOptions(String itemname, IconData icons) {
    return ListTile(
      leading: Icon(icons),
      title: Text(itemname),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  void getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    prodname = pref.getStringList(Constants.PRODUCT_NAME);
    prodqty = pref.getStringList(Constants.PRODUCT_QUANTITY);
    prodprice = pref.getStringList(Constants.PRODUCT_PRICE);
  }
}
