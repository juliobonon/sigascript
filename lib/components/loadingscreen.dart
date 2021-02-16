import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: 200,
              child: Image.asset(
                'imgs/siga.png',
              ),
              duration: Duration(seconds: 1),
              curve: Curves.bounceIn,
            ),
            CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.red,
            ),
            SizedBox(height: 20),
            Text('Carregando, aguarde...'),
          ],
        ),
      ),
    );
  }
}
