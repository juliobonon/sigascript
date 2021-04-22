import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigascript/components/loadingscreen.dart';
import 'package:sigascript/providers/student_provider.dart';
import 'package:sigascript/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userData = FirebaseAuth.instance.currentUser;
  var data;
  bool sigaConfigured;

  void _signOut() async {
    try {
      context.read<Auth>().signOut();
    } catch (e) {
      print(e);
    }
  }

  List<String> getSigaAccount() {
    List<String> credentials = [];

    if ((data['rgSiga'] != null) & (data['sigaPassword'] != null)) {
      credentials.add(data['rgSiga']);
      credentials.add(data['sigaPassword']);
    } else {}

    return credentials;
  }

  @override
  Widget build(BuildContext context) {
    final studentData = Provider.of<StudentProvider>(context);
    var userID = FirebaseAuth.instance.currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _signOut),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return LoadingContainer();
            return Container(
              child: Text(snapshot.data['rgSiga']),
            );
          },
        ),
      ),
    );
  }
}
