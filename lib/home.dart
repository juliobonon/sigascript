import 'package:flutter/material.dart';
import 'package:sigascript/pages/home.dart';
import 'package:sigascript/pages/homeNotRegistered.dart';
import 'package:sigascript/providers/student_provider.dart';
import 'package:sigascript/routemanager.dart';
import 'package:sigascript/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sigascript/services/validator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StudentProvider studentData;

  void _signOut() async {
    try {
      context.read<Auth>().signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    studentData = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Fatec Campinas"),
        actions: [
          Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: dialogBox(),
                      actions: [
                        ElevatedButton(
                          child: Text("Ok"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: _signOut,
            ),
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: studentData.data,
          builder: (context, snapshot) {
            print(snapshot.data['isSigaConfigured']);
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
            return RouteManager(
              rg: snapshot.data['rgSiga'],
              pw: snapshot.data['sigaPassword'],
            );
          },
        ),
      ),
    );
  }
}

Widget dialogBox() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    width: 300,
    height: 350,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'imgs/cps.jpg',
          width: 200,
        ),
        SizedBox(height: 20),
        Text(
          "Sobre o Projeto",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 10),
        Text(
          "Esse aplicativo não tem acesso ao banco de dados do SIGA, todos os dados são obtidos a partir de um programa.",
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
