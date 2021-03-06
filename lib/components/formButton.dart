import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  FormButton({this.name, this.function});

  final name;
  final function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60),
      child: ButtonTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minWidth: 250,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
