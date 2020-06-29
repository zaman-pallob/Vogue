import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          itemBlock("Blazers", AssetImage('Options/blazer.png')),
          itemBlock("Coat", AssetImage('Options/coat.png')),
          itemBlock("Shirt", AssetImage('Options/shirt.png')),
          itemBlock("Tshirt", AssetImage('Options/tshirt.png')),
          itemBlock("Trouser", AssetImage('Options/trousers.png')),
          itemBlock("Vest", AssetImage('Options/vest.png')),
          itemBlock("Gown", AssetImage('Options/gown.png')),
          itemBlock("Skirt", AssetImage('Options/skirt.png')),
          itemBlock("Lingeries", AssetImage('Options/bikini.png')),
        ],
      ),
    );
  }

  Widget itemBlock(String name, AssetImage assetImage) {
    return Container(
      width: 110,
      height: 80,
      padding: EdgeInsets.all(1),
      child: Card(
        elevation: 2.0,
        color: Colors.orangeAccent,
        child: ListTile(
          onTap: () {
            print(name);
          },
          title: Container(
            height: 40,
            child: Image(
              image: assetImage,
              fit: BoxFit.fitHeight,
            ),
          ),
          subtitle: Container(
            height: 30,
            padding: EdgeInsets.all(3),
            child: Text(
              name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
