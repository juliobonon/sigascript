import 'package:flutter/material.dart';
import 'package:sigascript/pages/dashboard.dart';
import 'package:sigascript/pages/grades.dart';
import 'package:sigascript/pages/home.dart';
import 'package:sigascript/services/auth.dart';
import 'package:provider/provider.dart';

class RouteManager extends StatefulWidget {
  final String pw;
  final String rg;
  RouteManager({this.rg, this.pw});
  @override
  _RouteManagerState createState() => _RouteManagerState(this.rg, this.pw);
}

class _RouteManagerState extends State<RouteManager> {
  _RouteManagerState(String _rg, String _pw) {
    this.rg = _rg;
    this.pw = _pw;
  }
  var rg;
  var pw;
  int _index = 1;

  void _signOut() async {
    try {
      context.read<Auth>().signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(
        pw: pw,
        rg: rg,
      ),
    );
  }
}
