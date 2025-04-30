import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imatching/login.dart';
import 'package:imatching/play.dart';
import 'package:imatching/score.dart';
import 'package:imatching/userController.dart' as userController;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => Home();
}

class Home extends State<MyHomePage> {
  String name = "";

  void CheckUser() async {
    String username = await userController.checkUser();
    setState(() {
      name = username;
    });
  }

  void doLogout(BuildContext context) async {
    userController.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyLogin()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    CheckUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      drawer: Drawer(
        backgroundColor: Colors.deepPurple.shade700,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name, style: GoogleFonts.pressStart2p(fontSize: 10)),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
              ),
              decoration: BoxDecoration(color: Colors.deepPurple.shade800),
            ),
            ListTile(
              title: Text("Scores", style: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.white)),
              leading: Icon(Icons.score, color: Colors.white),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Score()));
              },
            ),
            ListTile(
              title: Text("Log Out", style: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.redAccent)),
              leading: Icon(Icons.logout, color: Colors.redAccent),
              onTap: () => doLogout(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        title: Text("🧠 Imatching", style: GoogleFonts.pressStart2p(fontSize: 14)),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🎮 IMATCHING", style: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 24),
              Text("HOW TO PLAY", style: GoogleFonts.pressStart2p(fontSize: 12, color: Colors.amberAccent)),
              const SizedBox(height: 16),
              _gameStep("1. Click the card to flip it open"),
              _gameStep("2. Match 2 cards of the same image to score"),
              _gameStep("3. Match all cards within time to win!"),
              const SizedBox(height: 32),
              SizedBox(
                width: 280,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Play()));
                  },
                  child: Text("▶ PLAY", style: GoogleFonts.pressStart2p(fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
