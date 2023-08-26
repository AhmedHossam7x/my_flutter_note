// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/coustomtextform.dart';
import 'package:flutter_application_1/component/crud.dart';
import 'package:flutter_application_1/component/valid.dart';
import 'package:flutter_application_1/constant/linkapi.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Crud crud = Crud();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passw = TextEditingController();
  bool isLoading = false;

  signUp() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await crud.postRequast(
        linkSignUp,
        {
          "username": userName.text,
          "email": email.text,
          "password": passw.text
        },
      );

      isLoading = false;
      setState(() {});

      if (response["status"] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      Image.asset("assets/images/logo.png",
                          width: 200, height: 200, fit: BoxFit.fill),
                      CustomTextForm(
                        controller: userName,
                        hint: "UserName",
                        valid: (val) {
                          return validInput(val!, 4, 6);
                        },
                      ),
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
                          return validInput(val!, 4, 6);
                        },
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async {
                          await signUp();
                        },
                        child: const Text("SignUp"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => {Navigator.of(context).pushNamed("login")},
                        child: const Text('Login'),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
