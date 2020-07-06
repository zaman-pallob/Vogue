import 'package:shared_preferences/shared_preferences.dart';

class CartItems {
  String username = "", number = "";
  List<String> prodname = new List();
  List<String> prodprice = new List();
  List<String> prodqty = new List();
  CartItems() {
    getData();
  }
  void getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    number = pref.getString("number");
    prodname = pref.getStringList("prodname");
    prodprice = pref.getStringList("prodprice");
    prodqty = pref.getStringList("prodqty");
  }

  void clearAll() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("prodname", new List());
    pref.setStringList("prodqty", new List());
    pref.setStringList("prodprice", new List());
  }

  void clearSelected(String name, String qty, String price) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    prodname = pref.getStringList("prodname");
    prodprice = pref.getStringList("prodprice");
    prodqty = pref.getStringList("prodqty");
    prodname.remove(name);
    prodprice.remove(price);
    prodqty.remove(qty);
    pref.setStringList("prodname", prodname);
    pref.setStringList("prodqty", prodqty);
    pref.setStringList("prodprice", prodprice);
  }

  List<String> getProdname() {
    return prodname;
  }

  List<String> getProdprice() {
    return prodprice;
  }

  List<String> getProdqty() {
    return prodqty;
  }

  String getUsername() {
    return username;
  }

  String getNumber() {
    return number;
  }
}
