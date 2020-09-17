import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sigascript/home.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siga Script',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
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
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(
                universityName,
                style: TextStyle(color: Colors.black, fontSize: 35),
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
                decoration: InputDecoration(
                    labelText: 'Enter your RG', border: InputBorder.none),
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
                decoration: InputDecoration(
                    labelText: 'Password', border: InputBorder.none),
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
