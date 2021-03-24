import 'package:flutter/material.dart';
import 'package:sigascript/components/formButton.dart';
import 'package:sigascript/components/inputContainer.dart';
import 'package:sigascript/services/emailValidator.dart';

class HomeAnonymous extends StatelessWidget {
  HomeAnonymous({this.validator});

  final Validator validator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              obscureText: false,
            ),
            SizedBox(height: 10),
            InputContainer(
              name: "Senha",
              validator: validator.validatePassword,
              obscureText: true,
            ),
            SizedBox(height: 20),
            FormButton(
              name: "Cadastrar SIGA",
            ),
          ],
        ),
      ),
    );
  }
}
