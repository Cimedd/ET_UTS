import 'package:flutter/material.dart';
import 'package:imatching/userController.dart' as userController;

class Score extends StatelessWidget {

  Score({super.key});
  final List<Color> colors = [Colors.amber, Colors.grey , Colors.brown];
  final List<IconData> rankIcon = [Icons.looks_one_outlined, Icons.looks_two_outlined, Icons.looks_3_outlined];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("High Scores"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: userController.getScores(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Something went wrong!');
              } else {
                final scores = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(scores.length, (index) {
                    var item = scores[index];
                    return scoreCard(
                      item['username'],
                      item['score'],
                      index
                    );
                  }),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Row scoreCard(String username, int score, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(rankIcon[index], color: colors[index]),
        SizedBox(width: 20,),
        Text(username, style: TextStyle(fontSize: 24),),
        SizedBox(width: 12,),
        Text(score.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      ],
    );
  }
}
