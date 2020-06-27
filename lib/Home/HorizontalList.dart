import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
          itemBlock("name", Icons.account_circle),
        ],
      ),
    );
  }

  Widget itemBlock(String name, IconData icon) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(1),
      child: Card(
        child: ListTile(
          title: Icon(icon),
          subtitle: Container(
            padding: EdgeInsets.all(3),
            alignment: Alignment.topCenter,
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
