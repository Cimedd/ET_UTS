import 'package:flutter/material.dart';
import 'package:imatching/home.dart';
import 'package:imatching/play.dart';
import 'package:imatching/score.dart';
import 'package:imatching/userController.dart' as userController;

class Result extends StatefulWidget {
  final int score;
  const Result({super.key, required this.score});

  @override
  State<StatefulWidget> createState() {
    return _Result();
  }
}

class _Result extends State<Result> {

  void SaveScore() async {
    String username = await userController.checkUser();
    Map<String, dynamic> scoreData = {
      'username': username,
      'score': widget.score
    };
    userController.saveScore(scoreData);
  }

  @override
  void initState() {
    super.initState();
    SaveScore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 180,),
            Text("Score", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),),
            SizedBox(height: 4,),
            Text(widget.score.toString(), style: TextStyle(fontSize: 24)),
            SizedBox(height: 4,),
            Text('If high score'),
            SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Play()),
                );
              },
              child: Text("Play Again"),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Score()),
                );
              },
              child: Text("High Scores"),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Main Menu"),
            ),
          ],
        ),
      ),
    );
  }
}
