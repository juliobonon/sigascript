import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  InputContainer(
      {this.controller, this.name, this.obscureText, this.validator});

  final controller;
  final name;
  final bool obscureText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          labelText: name,
          border: InputBorder.none,
          labelStyle: TextStyle(color: Colors.black),
        ),
        controller: controller,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
