import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigascript/components/loadingscreen.dart';
import 'package:sigascript/pages/home.dart';
import 'package:sigascript/pages/homeNotRegistered.dart';
import 'package:sigascript/services/auth.dart';
import 'package:sigascript/services/validator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userData = FirebaseAuth.instance.currentUser;
  var data;
  bool sigaConfigured;

  get() {
    print(userData.uid + "Logged as");
    FirebaseFirestore.instance
        .collection("users")
        .doc(userData.uid)
        .get()
        .then((value) {
      setState(() {
        data = value.data();
      });
    });

    if (data['isSigaConfigured'] == false) {
      setState(() {
        sigaConfigured = false;
      });
    } else {
      setState(() {
        sigaConfigured = true;
      });
    }
  }

  List<String> getSigaAccount() {
    List<String> credentials = [];

    FirebaseFirestore.instance
        .collection("users")
        .doc(userData.uid)
        .get()
        .then((value) => {
              setState(() {
                data = value.data();
              }),
            });

    if ((data['rgSiga'] != null) & (data['sigaPassword'] != null)) {
      credentials.add(data['rgSiga']);
      credentials.add(data['sigaPassword']);
    } else {}

    return credentials;
  }

  void _signOut() async {
    try {
      context.read<Auth>().signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _signOut),
        ],
      ),
      body: teste(),
    );
  }

  Widget teste() {
    get();
    if (sigaConfigured == true) {
      var credentials = getSigaAccount();
      if (credentials != null) {
        return Home(
          rg: credentials[0],
          pw: credentials[1],
        );
      }
    } else if (sigaConfigured == false) {
      return HomeAnonymous(
        auth: new Auth(),
        validator: new Validator(),
      );
    }
    return LoadingScreen();
  }
}
