import 'package:flutter/material.dart';
import 'package:imatching/home.dart';
import 'package:imatching/main.dart';
import 'package:imatching/userController.dart' as userController;

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMatching',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _usernamecontroller.text = "";
    _passwordcontroller.text = "";
  }

  void doLogin() async {
    userController.saveUser(_usernamecontroller.text);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainApp()),
      (route) => false,
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        height: 300,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.blue,
          boxShadow: [BoxShadow(blurRadius: 5)],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (v) {
                },
                controller: _usernamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                     if (_usernamecontroller.text.trim().isEmpty) {
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
                  child: Text('Login', style: TextStyle(fontSize: 25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('Login')),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: _usernamecontroller,
    //           decoration: InputDecoration(labelText: "Username"),
    //           onSubmitted: (v) {
    //             setState(() {});
    //           },
    //         ),
    //         TextField(
    //           controller: _passwordcontroller,
    //           decoration: InputDecoration(labelText: "Password"),
    //           onSubmitted: (v) {
    //             setState(() {});
    //           },
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             if (_usernamecontroller.text.trim().isEmpty) {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 SnackBar(
    //                   content: Text("Please enter your username"),
    //                   duration: Duration(seconds: 2),
    //                 ),
    //               );
    //             } else {
    //               doLogin();
    //             }
    //           },
    //           child: const Text("Login"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
