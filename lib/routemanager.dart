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
  _RouteManagerState createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  int _index = 1;
  final _pageOptions = [
    Dashboard(),
    Home(),
    Grades(),
  ];

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
      body: _pageOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Notas",
            icon: Icon(Icons.dashboard),
          ),
        ],
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
