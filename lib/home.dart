import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigascript/components/loadingscreen.dart';
import 'package:sigascript/pages/homeNotRegistered.dart';
import 'package:sigascript/routemanager.dart';
import 'package:sigascript/services/auth.dart';
import 'dart:async';

import 'package:sigascript/services/validator.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    print(users);
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if (data['isSigaConfigured'] == false) {
            return HomeAnonymous(auth: new Auth(), validator: new Validator());
          } else {
            return RouteManager();
          }
        }

        return LoadingScreen();
      },
    );
  }
}

class GetSigaState {
  final String useruid;
  GetSigaState(this.useruid);
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getState(String useruid) async {
    return await users.doc(useruid).get();
  }
}

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;

  getUserData() async {
    User userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      print(user);
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _signOut)],
      ),
      body: GetUserName(user.uid),
    );
  }
}
