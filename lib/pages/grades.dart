import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Grade>> fetchPhotos(http.Client client) async {
  final response = await client.get('http://0.0.0.0:3000/presences');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Grade> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Grade>((json) => Grade.fromJson(json)).toList();
}

class Grade {
  final String grade;
  final String presences;
  final String absences;
  final String grade1;
  final String grade2;
  final String grade3;
  final String grade4;

  Grade(
      {this.grade1,
      this.grade2,
      this.grade3,
      this.grade4,
      this.grade,
      this.presences,
      this.absences});

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
        grade: json['grade'],
        presences: json['presences'],
        absences: json['absences'],
        grade1: json['grade1'],
        grade2: json['grade2'],
        grade3: json['grade3'],
        grade4: json['grade4']);
  }
}

class Grades extends StatefulWidget {
  @override
  _GradesState createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Grade>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GradesPage(grades: snapshot.data)
              : CircularProgressIndicator();
        },
      ),
    );
  }
}

class GradesPage extends StatefulWidget {
  GradesPage({Key key, this.grades}) : super(key: key);
  final List<Grade> grades;
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            child: Center(
              child: Image.asset(
                'imgs/evaluation.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: widget.grades.length,
              itemBuilder: (context, int index) {
                return GradeContainer(
                  grade: widget.grades[index].grade,
                  absences: widget.grades[index].absences,
                  presences: widget.grades[index].presences,
                  grade1: widget.grades[index].grade1,
                  grade2: widget.grades[index].grade2,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class GradeContainer extends StatefulWidget {
  const GradeContainer(
      {Key key,
      this.grade,
      this.presences,
      this.absences,
      this.grade1,
      this.grade2})
      : super(key: key);

  final String grade;
  final String presences;
  final String absences;
  final String grade1;
  final String grade2;

  @override
  _GradeContainerState createState() => _GradeContainerState();
}

class _GradeContainerState extends State<GradeContainer> {
  void getGrade() => print(widget.grade2);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[800],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                widget.grade,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset('imgs/check.png'),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(
                                'Presenças:' + widget.presences,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            gradeWidget(widget.grade1, widget.grade2)
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset('imgs/remove.png'),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(
                                'Faltas:' + widget.absences,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget gradeWidget(x, y) {
  if (x != null && y != null) {
    return Column(
      children: [
        Text(x),
        Text(y),
      ],
    );
  } else {
    return SizedBox(width: 1);
  }
}
