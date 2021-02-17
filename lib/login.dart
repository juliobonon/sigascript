import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sigascript/components/loadingscreen.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final String universityName = 'Fatec Campinas';
  bool _isLoading = false;
  TextEditingController rgController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signIn(String rg, String password) async {
    Map data = {
      'rg': rg,
      'password': password,
    };

    var jsonData = null;
    var response = await http.post("http://0.0.0.0:3000/login", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(
        () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login error'),
            content: Text('Cheque suas credenciais e conexão'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Voltar'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                            contentPadding: EdgeInsets.all(4),
                            focusColor: Colors.red,
                            labelText: 'Digite seu RG',
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                          controller: rgController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o RG';
                            } else if (value.length != 11) {
                              return 'Um RG válido tem apenas 11 caracteres';
                            }
                          },
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
                            contentPadding: EdgeInsets.all(4),
                            labelText: 'Password',
                            border: InputBorder.none,
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Digite sua senha';
                            }
                          },
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
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(
                                top: 20,
                                left: 40,
                                right: 40,
                                bottom: 20,
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          label: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              signIn(
                                  rgController.text, passwordController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        child: Text('Made with ❤️ by juliobonon'),
                        onTap: () => launch('https://github.com/juliobonon'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
