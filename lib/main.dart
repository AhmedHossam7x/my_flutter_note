import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/auth/login.dart';
import 'package:flutter_application_1/app/auth/signup.dart';
import 'package:flutter_application_1/app/auth/success.dart';
import 'package:flutter_application_1/app/home.dart';
import 'package:flutter_application_1/app/note/add.dart';
import 'package:flutter_application_1/app/note/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rect API',
      initialRoute:
          sharedPreferences.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const SignUp(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
        "add": (context) => const AddNote(),
        "edit": (context) => const EditNote()
      },
    );
  }
}
