import 'package:flutter/material.dart';
import 'package:imatching/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imatching/userController.dart' as userController;

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMatching',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple.shade200,
        fontFamily: 'PressStart2P',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void doLogin() async {
    userController.saveUser(_usernameController.text);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainApp()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "IMATCHING",
                  style: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white)
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepPurple.shade400,
                    border: OutlineInputBorder(),
                    labelText: 'USERNAME',
                    labelStyle: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepPurple.shade400,
                    border: OutlineInputBorder(),
                    labelText: 'PASSWORD',
                    labelStyle: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_usernameController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter your username"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        doLogin();
                      }
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
