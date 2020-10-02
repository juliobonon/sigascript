import 'package:flutter/material.dart';
import 'package:sigascript/grades.dart';
import 'package:sigascript/home.dart';
import 'package:sigascript/test.dart';

class RouteManager extends StatefulWidget {
  @override
  _RouteManagerState createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  int _index = 1;
  final _pageOptions = [Pelando(), Home(), Grades()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Siga Fatec Campinas"),
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
                      content: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 300,
                        height: 350,
                        child: Column(
                          children: [
                            Image.asset('imgs/cps.png'),
                            Text(
                              "Sobre o Projeto",
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Esse aplicativo não tem acesso ao banco de dados do SIGA, todos os dados são obtidos a partir de um script.",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      actions: [
                        RaisedButton(
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
        ],
      ),
      body: _pageOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            title: Text("Dashboard"),
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Notas"),
            icon: Icon(Icons.dashboard),
          ),
        ],
      ),
    );
  }
}
