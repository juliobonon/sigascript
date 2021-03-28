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

  void updateSigaState(CollectionReference users, user) {
    users
        .doc(user)
        .update({'isSigaConfigured': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void addSigaCredentials(CollectionReference users, user, rg, sigaPassword) {
    users
        .doc(user)
        .update(
          {
            'rgSiga': rg,
            'sigaPassword': sigaPassword,
          },
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void validateAndSubmit(String user, rg, sigaPassword) {
    if (validateForm()) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      updateSigaState(users, user);
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
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Não configurou o Siga ainda? 🤔",
                style: TextStyle(fontSize: 20),
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
              FormButton(
                name: "Cadastrar SIGA",
                function: () {
                  validateAndSubmit(user.uid, _rg.text, _sigaPassword.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
