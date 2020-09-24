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
              onPressed: () {},
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
