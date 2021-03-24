import 'package:flutter/material.dart';
import 'package:sigascript/components/formButton.dart';
import 'package:sigascript/components/inputContainer.dart';
import 'package:sigascript/services/auth.dart';
import 'package:sigascript/services/emailValidator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn, this.validator});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  final Validator validator;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final String universityName = 'Fatec Campinas';
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _user = TextEditingController();
  TextEditingController _repeatPassword = TextEditingController();

  FormType _formType = FormType.login;

  bool validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateForm()) {
      if (_formType == FormType.login) {
        try {
          User userId = await widget.auth
              .signInWithEmailAndPassword(_email.text, _password.text);
          print("Signed in: " + userId.uid);
          widget.onSignedIn();
        } catch (e) {
          print(e);
        }
      } else {
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
  }

  @override
  Widget build(BuildContext context) {
    if (_formType == FormType.login) {
      return loginForm(widget.validator);
    } else {
      return registerForm(widget.validator);
    }
  }

  Widget loginForm(Validator validator) {
    return Scaffold(
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
                  height: 50,
                ),
                InputContainer(
                  name: "Email",
                  controller: _email,
                  validator: validator.validateEmail,
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                InputContainer(
                  name: "Senha",
                  controller: _password,
                  validator: validator.validatePassword,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                FormButton(
                  name: "Login",
                  function: validateAndSubmit,
                ),
                SizedBox(height: 10),
                FormButton(
                  name: "Registrar",
                  function: () {
                    setState(() {
                      _formType = FormType.register;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
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

  Widget registerForm(Validator validator) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _formType = FormType.login;
                      },
                    );
                  },
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
              InputContainer(
                name: "User",
                controller: _user,
                validator: validator.validatePassword,
                obscureText: false,
              ),
              SizedBox(height: 10),
              InputContainer(
                name: "Email",
                controller: _email,
                validator: validator.validateEmail,
                obscureText: false,
              ),
              SizedBox(height: 10),
              InputContainer(
                name: "Senha",
                controller: _password,
                validator: validator.validatePassword,
                obscureText: true,
              ),
              SizedBox(height: 10),
              InputContainer(
                name: "Digite sua senha novamente",
                controller: _repeatPassword,
                validator: validator.validatePassword,
                obscureText: true,
              ),
              SizedBox(height: 20),
              FormButton(
                name: "Registrar",
                function: validateAndSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
