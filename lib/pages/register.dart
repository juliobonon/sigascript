import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  TextEditingController emailValidator = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: 300,
            height: 60,
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
              controller: emailValidator,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Digite sua senha';
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
