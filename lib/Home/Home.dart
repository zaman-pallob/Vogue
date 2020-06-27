import 'package:Vogue/Home/HomeSlider.dart';
import 'package:Vogue/Home/HorizontalList.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Vogue"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          drawerHeader("Atikur Zaman Pallob", "atikurzamanpallob@gmail.com",
              Icons.account_circle),
          drawerOptions("Settings", Icons.settings),
          drawerOptions("Dashboard", Icons.dashboard),
          drawerOptions("Recent", Icons.bubble_chart),
          drawerOptions("Total", Icons.equalizer),
          drawerOptions("Settings", Icons.settings),
          drawerOptions("Settings", Icons.settings),
          drawerOptions("About", Icons.info),
        ],
      )),
      body: ListView(
        children: <Widget>[
          HomeSlider(),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text("Categories"),
          ),
          HorizontalList(),
        ],
      ),
    );
  }

  Widget drawerHeader(String name, String email, IconData icons) {
    return UserAccountsDrawerHeader(
      accountName: Text(name),
      accountEmail: Text(email),
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
}
