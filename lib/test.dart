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

class Pelando extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PromoScrapper'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? MainPage(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.photos}) : super(key: key);
  final List<Photo> photos;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
              itemCount: widget.photos.length,
              itemBuilder: (context, int index) {
                return Grade(
                  gradename: widget.photos[index].gradename,
                  id: widget.photos[index].id,
                  job: widget.photos[index].job,
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}

class Grade extends StatefulWidget {
  Grade({Key key, this.gradename, this.id, this.job}) : super(key: key);

  final String gradename;
  final String id;
  final String job;

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
          child: Column(
            children: [
              Text(
                widget.gradename,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
