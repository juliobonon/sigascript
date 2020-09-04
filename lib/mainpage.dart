import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('http://192.168.15.12:5000/grades');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String gradename;
  final String id;
  final String job;

  Photo({this.gradename, this.id, this.job});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      gradename: json['gradename'] as String,
      id: json['id'] as String,
      job: json['job'] as String,
    );
  }
}

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
