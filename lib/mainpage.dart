import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> grades = [
    'Algoritmos',
    'Engenharia de Software',
    'Inteligência Artificial'
  ];
  String grade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('imgs/grade.png'),
              SizedBox(
                width: 10,
              ),
              Text(
                "Notas",
                style: TextStyle(color: Colors.black, fontSize: 45),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: grades.length,
              itemBuilder: (context, index) {
                grade = grades[index];
                return Grade(name: grade);
              },
            ),
          ),
        ),
      ],
    ));
  }
}

class Grade extends StatefulWidget {
  Grade({Key key, this.name}) : super(key: key);

  final String name;

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
