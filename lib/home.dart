import 'package:flutter/material.dart';
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
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
              ),
            ),
            ListTile(
              title: Text("Scores"),
              leading: Icon(Icons.score),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Score()),
                );
              },
            ),
            ListTile(
              title: Text("Log Out"),
              leading: Icon(Icons.logout),
              iconColor: Colors.red,
              onTap: () {
                doLogout(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Imatching"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Imatching", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
            SizedBox(height: 24,),
            Text("How To Play", style: TextStyle(fontSize: 24),),
            SizedBox(height: 4,),
            Text("1. Click the card to flip it open",  style: TextStyle(fontSize: 16),),
            SizedBox(height: 4,),
            Text("2. Match 2 card of the same image to get point",  style: TextStyle(fontSize: 16),),
            SizedBox(height: 4,),
            Text("3. Match all card within the time to win!",  style: TextStyle(fontSize: 16),),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Play(),
                  ), // Navigate to Play screen
                );
              },
              child: Text("Play"),
            ),
          ],
        ),
      ),
    );
  }
}
