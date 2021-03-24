import 'package:flutter/material.dart';
import 'package:sigascript/login.dart';
import 'package:sigascript/routemanager.dart';
import 'package:sigascript/services/emailValidator.dart';
import 'services/auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth, this.validator});
  final BaseAuth auth;
  final Validator validator;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
          validator: widget.validator,
        );
      case AuthStatus.signedIn:
        return new RouteManager(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}
