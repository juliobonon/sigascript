import 'package:flutter/material.dart';
import 'package:sigascript/register.dart';
import 'package:sigascript/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final String universityName = 'Fatec Campinas';
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        User userId = await widget.auth
            .signInWithEmailAndPassword(_email.text, _password.text);
        print('Signed in: ' + userId.uid);
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: buildLoginForm(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildLoginForm() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'imgs/fatec.png',
          width: 300,
        ),
      ),
      SizedBox(
        height: 50,
      ),
      Container(
        width: 330,
        height: 60,
        padding: EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        child: TextFormField(
          style: TextStyle(color: Colors.red),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(4),
            focusColor: Colors.red,
            labelText: 'Digite seu email',
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          controller: _email,
          validator: (value) {
            if (value.isEmpty) {
              return 'Informe o e-mail';
            }
          },
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        width: 330,
        height: 60,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        child: TextFormField(
          style: TextStyle(
            color: Colors.red,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(4),
            labelText: 'Senha',
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.black),
          ),
          controller: _password,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minWidth: 250,
        height: 50,
        child: ElevatedButton.icon(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.only(
                top: 15,
                left: 59,
                right: 59,
                bottom: 15,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          label: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            validateAndSubmit();
          },
        ),
      ),
      SizedBox(height: 10),
      ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minWidth: 200,
        height: 50,
        child: ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward_ios_rounded),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.only(
                  top: 15,
                  left: 40,
                  right: 45,
                  bottom: 15,
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            label: Text(
              "Registrar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(
                    auth: widget.auth,
                    onSignedIn: widget.onSignedIn,
                  ),
                ),
              );
            }),
      ),
      SizedBox(
        height: 20,
      ),
      InkWell(
        child: Text('Made with ❤️ by juliobonon'),
        onTap: () => launch('https://github.com/juliobonon'),
      ),
    ];
  }
}
