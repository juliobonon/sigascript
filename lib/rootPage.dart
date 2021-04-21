import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigascript/home.dart';
import 'package:sigascript/login.dart';
import 'package:sigascript/services/validator.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    } else {
      return LoginPage(
        validator: new Validator(),
      );
    }
  }
}
