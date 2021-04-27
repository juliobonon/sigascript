import 'package:flutter/material.dart';

class LearnAboutSiga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 40),
          Image.asset(
            'imgs/Chat_PNG.png',
            width: 300,
            height: 250,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Acesse suas notas e faltas \n diretamente do seu celular!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
