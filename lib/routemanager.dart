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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('imgs/cps.jpg', width: 200),
                            SizedBox(height: 20),
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
