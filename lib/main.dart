import 'package:flutter/material.dart';
import 'package:imatching/home.dart';
import 'package:imatching/login.dart';
import 'package:imatching/userController.dart' as userController;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  userController.checkUser().then((String result) {
    if (result == '') {
      runApp(MyLogin());
    } else {
      runApp(MainApp());
    }
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MyHomePage(),
    );
  }
}
