import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

  Profile({this.name, this.ra, this.urlImage});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['nome'],
      ra: json['ra'],
      urlImage: json['img'],
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Profile> futureProfile;
  String title = 'Siga Fatec Campinas';

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: FutureBuilder<Profile>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(
                  width: 340,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 70,
                        top: 30,
                        child: CircleAvatar(
                          radius: 105,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                NetworkImage(snapshot.data.urlImage),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 70,
                        child: Text(
                          snapshot.data.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 90,
                        child: Text(
                          "RA: " + snapshot.data.ra,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
