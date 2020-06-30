import 'package:flutter/material.dart';

class Homegridview extends StatefulWidget {
  @override
  _HomegridviewState createState() => _HomegridviewState();
}

class _HomegridviewState extends State<Homegridview> {
  List item = ["1", "2", "3", "4", "5", "6", "7", "8"];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: item.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return singleBlock(index, item[index]);
        });
  }

  Widget singleBlock(int index, String itemname) {
    return InkWell(
      onTap: () {
        print(itemname);
      },
      child: GridTile(
        footer: ListTile(
          leading: Text("name"),
          title: Text("price"),
          subtitle: Text("discount"),
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          child: Card(
            child: Image(
              image: AssetImage('images/f2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
