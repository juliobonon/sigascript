import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigascript/components/formButton.dart';
import 'package:sigascript/components/inputContainer.dart';
import 'package:sigascript/services/auth.dart';
import 'package:sigascript/services/validator.dart';

class HomeAnonymous extends StatefulWidget {
  HomeAnonymous({this.validator, this.auth});
  final BaseAuth auth;
  final Validator validator;

  @override
  _HomeAnonymousState createState() => _HomeAnonymousState();
}

class _HomeAnonymousState extends State<HomeAnonymous> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _rg = new TextEditingController();
  TextEditingController _sigaPassword = new TextEditingController();

  bool validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void addSigaCredentials(CollectionReference users, user, rg, sigaPassword) {
    print('rg' + rg.toString());
    print('pw' + sigaPassword.toString());
    if (rg == null && sigaPassword == null) {
      users.doc(user).update({'isSigaConfigured': false});
    } else {
      users.doc(user).update({'isSigaConfigured': true});
    }
    try {
      users.doc(user).update(
        {
          'rgSiga': rg,
          'sigaPassword': sigaPassword,
        },
      ).then((value) => print("User Added"));
    } catch (e) {
      print(e);
    }
  }

  void validateAndSubmit(String user, rg, sigaPassword) {
    if (validateForm()) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      addSigaCredentials(users, user, rg, sigaPassword);
    }
  }

  User user;

  getUserData() async {
    User userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      print(user);
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Configure sua conta do SIGA",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Pra configurar sua conta é muito simples, digite o RG e senha utilizados no portal oficial da Fatec Campinas",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            InputContainer(
              name: "RG",
              controller: _rg,
              obscureText: false,
              validator: widget.validator.validateRG,
            ),
            SizedBox(height: 10),
            InputContainer(
              name: "Senha",
              controller: _sigaPassword,
              validator: widget.validator.validatePassword,
              obscureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 50,
              child: FormButton(
                name: "Cadastrar SIGA",
                function: () {
                  validateAndSubmit(user.uid, _rg.text, _sigaPassword.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
