import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String universityName = 'Fatec Campinas';
  bool _isLoading = false;
  TextEditingController rgController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signIn(String rg, String password) async {
    Map data = {'rg': rg, 'password': password};
    var jsonData = null;
    var response =
        await http.post("http://192.168.15.10:5000/login", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
      });
    } else {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Erro de Login"),
          content: Text(
              "Verifique suas credenciais e sua conexão e tente novamente."),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'imgs/fatec.png',
                      width: 300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(color: Colors.red),
                      decoration: InputDecoration(
                        focusColor: Colors.red,
                        labelText: 'Enter your RG',
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      controller: rgController,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: 200,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        signIn(rgController.text, passwordController.text);
                      },
                    ),
                  ),
                ],
              ),
            )),
          );
  }
}
