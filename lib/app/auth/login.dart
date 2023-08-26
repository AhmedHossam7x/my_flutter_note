// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/coustomtextform.dart';
import 'package:flutter_application_1/component/crud.dart';
import 'package:flutter_application_1/constant/linkapi.dart';
import 'package:flutter_application_1/main.dart';

import '../../component/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController passw = TextEditingController();
  Crud crud = Crud();
  bool isLoading = false;

  login() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequast(
        linkLogin,
        {"email": email.text, "password": passw.text},
      );
      isLoading = false;
      setState(() {});
      if (response["status"] == "success") {
        sharedPreferences.setString("id", response['data']['id'].toString());
        sharedPreferences.setString("username", response['data']['username']);
        sharedPreferences.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          title: "Aleart",
          body: const Text("the password is wrong or there is no accunt"),
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      Image.asset("assets/images/logo.png",
                          width: 200, height: 200, fit: BoxFit.fill),
                      CustomTextForm(
                        controller: email,
                        hint: "Email",
                        valid: (val) {
                          return validInput(val!, 8, 20);
                        },
                      ),
                      CustomTextForm(
                        controller: passw,
                        hint: "Password",
                        valid: (val) {
                          return validInput(val!, 4, 8);
                        },
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async => {await login()},
                        child: const Text("LogIn"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () =>
                            {Navigator.of(context).pushNamed("signup")},
                        child: const Text('SigUp'),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
