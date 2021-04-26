import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sigascript/components/loadingscreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sigascript/components/profileBox.dart';

Future<Profile> fetchProfile(String rg, String pw) async {
  var queryparams = {
    'rg': rg,
    'pw': pw,
  };

  final response = await http.get(
    Uri.https('siga-fatec.herokuapp.com', '/profile', queryparams),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Profile.fromJson(jsonDecode(response.body));
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
  Home({this.rg, this.pw});

  final String rg;
  final String pw;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile(widget.rg, widget.pw);
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
            return CircularProgressIndicator();
          }
        },
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
