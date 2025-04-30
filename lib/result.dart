import 'package:flutter/material.dart';
import 'package:imatching/home.dart';
import 'package:imatching/play.dart';
import 'package:imatching/score.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isHighScore = false;
  void SaveScore() async {
    String username = await userController.checkUser();
    Map<String, dynamic> scoreData = {
      'username': username,
      'score': widget.score,
    };
    userController.saveScore(scoreData);
  }

  void checkHighScore() async {
    List<Map<String, dynamic>> scores =
        await userController.getScores(); // pastikan fungsi ini ada
    int maxScore =
        scores.isNotEmpty
            ? scores
                .map((s) => s['score'] as int)
                .reduce((a, b) => a > b ? a : b)
            : 0;

    if (widget.score > maxScore) {
      setState(() {
        isHighScore = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SaveScore();
    checkHighScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SCORE",
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.score.toString(),
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.yellow,
                ),
              ),
              const SizedBox(height: 12),
              if (isHighScore)
                Text(
                  "New High Score!",
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Play()),
                    );
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: GoogleFonts.pressStart2p(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Score()),
                    );
                  },
                  child: Text(
                    "HIGH SCORES",
                    style: GoogleFonts.pressStart2p(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    "MAIN MENU",
                    style: GoogleFonts.pressStart2p(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
