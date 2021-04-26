import 'package:flutter/material.dart';
import 'package:sigascript/pages/home.dart';
import 'package:sigascript/pages/homeNotRegistered.dart';
import 'package:sigascript/providers/student_provider.dart';
import 'package:sigascript/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sigascript/services/validator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _signOut() async {
    try {
      context.read<Auth>().signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentData = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _signOut),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: studentData.data,
          builder: (context, snapshot) {
            if (snapshot.data['isSigaConfigured'] == false) {
              return HomeAnonymous(
                validator: new Validator(),
              );
            } else if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            }
            return Home(
              rg: snapshot.data['rgSiga'],
              pw: snapshot.data['sigaPassword'],
            );
          },
        ),
      ),
    );
  }
}
