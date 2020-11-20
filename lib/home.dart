import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:percent_indicator/linear_percent_indicator.dart';

Future<Profile> fetchProfile() async {
  var url = 'https://siga-fatec.herokuapp.com/';
  final response = await http.get('$url/profile');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Profile.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Profile {
  String name;
  String ra;
  String urlImage;
  String pp;
  String pr;
  String courseName;
  String period;

  Profile({
    this.name,
    this.ra,
    this.urlImage,
    this.pp,
    this.pr,
    this.courseName,
    this.period,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['nome'],
      ra: json['ra'],
      urlImage: json['img'],
      pp: json['pp'],
      pr: json['pr'],
      courseName: json['course'],
      period: json['period'],
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ProfileBox(
                urlImage: snapshot.data.urlImage,
                name: snapshot.data.name,
                ra: snapshot.data.ra,
                pp: snapshot.data.pp,
                pr: snapshot.data.pr,
                course: snapshot.data.courseName,
                period: snapshot.data.period,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ProfileBox extends StatelessWidget {
  const ProfileBox({
    Key key,
    this.urlImage,
    this.name,
    this.ra,
    this.pr,
    this.pp,
    this.course,
    this.period,
  }) : super(key: key);

  final String urlImage;
  final String name;
  final String ra;
  final String pr;
  final String pp;
  final String course;
  final String period;

  @override
  Widget build(BuildContext context) {
    double resultPP = double.parse(pp);
    double resultPR = double.parse(pr);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 360,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 85,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(urlImage),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Center(
              child: Text(
                "RA: " + ra,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Curso: " + course,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 60,
              ),
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 2500,
                width: 200,
                lineHeight: 25,
                linearStrokeCap: LinearStrokeCap.butt,
                percent: resultPP / 100,
                leading: Text(
                  'PP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                center: Text(
                  pp + "%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                left: 60,
              ),
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 2500,
                width: 200,
                lineHeight: 25,
                progressColor: Colors.green,
                linearStrokeCap: LinearStrokeCap.butt,
                percent: resultPR / 10,
                leading: Text(
                  'PR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                center: Text(
                  pr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradeContainer extends StatelessWidget {
  const GradeContainer({
    Key key,
    this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[350],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lato',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
