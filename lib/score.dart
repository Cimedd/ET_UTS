import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imatching/userController.dart' as userController;

class Score extends StatelessWidget {
  Score({super.key});

  final List<Color> colors = [Colors.amber, Colors.grey, Colors.brown];
  final List<String> medals = ['🥇', '🥈', '🥉'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        title: Text(
          "🏆 High Scores",
          style: GoogleFonts.pressStart2p(fontSize: 14),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: userController.getScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!', style: TextStyle(color: Colors.white)));
          } else {
            final scores = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: scores.length,
              itemBuilder: (context, index) {
                var item = scores[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: scoreCard(item['username'], item['score'], index),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget scoreCard(String username, int score, int index) {
    return Card(
      elevation: 10,
      color: Colors.deepPurple.shade600,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Text(
          index < 3 ? medals[index] : '${index + 1}.',
          style: TextStyle(fontSize: 28),
        ),
        title: Text(
          username,
          style: GoogleFonts.pressStart2p(fontSize: 12, color: Colors.white),
        ),
        trailing: Text(
          score.toString(),
          style: GoogleFonts.pressStart2p(fontSize: 12, color: Colors.amberAccent),
        ),
      ),
    );
  }
}
