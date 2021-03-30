import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
        width: 350,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: periodBox(period),
              ),
            ),
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

Widget periodBox(String period) {
  bool manha = false;
  var size = 60.0;

  if (period == 'Manhã') {
    manha = true;
  }

  if (manha) {
    return Image.asset(
      'imgs/morning.png',
      width: size,
    );
  } else {
    return Image.asset(
      'imgs/night.png',
      width: size,
    );
  }
}
