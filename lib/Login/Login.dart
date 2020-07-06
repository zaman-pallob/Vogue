import 'package:Vogue/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 70,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          hintText: 'Name'),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                        controller: password,
                        decoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Number'),
                        obscureText: false),
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                      child: RaisedButton(
                        onPressed: () {
                          saveData(username.text, password.text);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      new Home(username.text, password.text)));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(3.0)),
                        child: Text('Login'),
                        textColor: Colors.white,
                        color: Colors.black,
                        highlightColor: Colors.green,
                        hoverColor: Colors.green,
                      ))
                ])));
  }

  void saveData(String username, String number) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", username);
    pref.setString("number", number);
  }
}
