import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString("user_id") ?? '';
  return userId;
}

Future<void> saveUser(String user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user_id", user);
}

 Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
 }

Future<void> saveScore(Map<String, dynamic> newScore) async {
  final prefs = await SharedPreferences.getInstance();

  String? jsonString = prefs.getString('top_scores');
  List<Map<String, dynamic>> scores = [];

  if (jsonString != null) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    scores = jsonList.map((item) => item as Map<String, dynamic>).toList();
  }

  scores.add(newScore);

  scores.sort((a, b) => b["score"].compareTo(a["score"]));

  if (scores.length > 3) {
    scores = scores.sublist(0, 3);
  }

  await prefs.setString('top_scores', jsonEncode(scores));
}


Future<List<Map<String, dynamic>>> getScores() async {
  final prefs = await SharedPreferences.getInstance();

  String? jsonString = prefs.getString('top_scores');

  if (jsonString != null) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => item as Map<String, dynamic>).toList();
  } else {
    return [
      {"username": "Player1", "score": 0},
      {"username": "Player2", "score": 0},
      {"username": "Player3", "score": 0},
    ];
  }
}
