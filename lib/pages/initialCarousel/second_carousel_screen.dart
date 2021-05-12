import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 40),
          Image.asset(
            'imgs/121.png',
            width: 240,
            height: 250,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Receba comunicados da faculdade e mantenha-se informado!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
