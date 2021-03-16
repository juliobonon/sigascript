import 'package:flutter/material.dart';
import 'package:sigascript/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  Register({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _user = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _repeatPassword = new TextEditingController();

  bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

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
            .createUserWithEmailandPassword(_email.text, _password.text);
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
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildRegisterForm(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildRegisterForm() {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pushNamed(
            '/',
          ),
        ),
      ),
      SizedBox(height: 20),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Crie uma conta",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 20),
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
            labelText: 'Usuário',
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.black),
          ),
          controller: _user,
          validator: (value) {
            if (value.isEmpty) {
              return 'Digite seu nome de usuário';
            }
          },
        ),
      ),
      SizedBox(height: 10),
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
            labelText: 'E-mail',
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.black),
          ),
          controller: _email,
          validator: (value) {
            if (value.isEmpty) {
              return 'Digite seu e-mail';
            } else if (isValidEmail(value) != true) {
              return 'Cheque seu e-mail';
            }
          },
        ),
      ),
      SizedBox(height: 10),
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
      SizedBox(height: 10),
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
            labelText: 'Digite a senha novamente',
            border: InputBorder.none,
            labelStyle: TextStyle(color: Colors.black),
          ),
          controller: _repeatPassword,
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Digite sua senha';
            }
          },
        ),
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.only(left: 60, right: 60),
        child: ButtonTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minWidth: 250,
          height: 50,
          child: ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward_ios_rounded),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.only(
                  top: 15,
                  left: 40,
                  right: 40,
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
              validateAndSubmit();
            },
          ),
        ),
      ),
    ];
  }
}
