import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:percent_indicator/linear_percent_indicator.dart';

Future<Profile> fetchProfile() async {
  var url = 'http://192.168.15.10:5000';
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
  String grade3;
  String grade4;
  String grade5;
  String grade6;
  String grade7;

  Profile({
    this.name,
    this.ra,
    this.urlImage,
    this.pp,
    this.pr,
    this.grade3,
    this.grade4,
    this.grade5,
    this.grade6,
    this.grade7,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['nome'],
      ra: json['ra'],
      urlImage: json['img'],
      pp: json['pp'],
      pr: json['pr'],
      grade3: json['grade3'],
      grade4: json['grade4'],
      grade5: json['grade5'],
      grade6: json['grade6'],
      grade7: json['grade7'],
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
              ),
            );
          } else {
            return CircularProgressIndicator();
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
  }) : super(key: key);

  final String urlImage;
  final String name;
  final String ra;
  final String pr;
  final String pp;

  @override
  Widget build(BuildContext context) {
    double resultPP = double.parse(pp);
    double resultPR = double.parse(pr);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 380,
        height: 440,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 125,
              top: 70,
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey[800],
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(urlImage),
                ),
              ),
            ),
            Positioned(
              bottom: 160,
              left: 117,
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
            Positioned(
              bottom: 190,
              left: 130,
              child: Text(
                "RA: " + ra,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Positioned(
              bottom: 110,
              right: 75,
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 2500,
                width: 200,
                lineHeight: 20,
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
            Positioned(
              bottom: 80,
              right: 75,
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 2500,
                width: 200,
                lineHeight: 20,
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
            )
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
