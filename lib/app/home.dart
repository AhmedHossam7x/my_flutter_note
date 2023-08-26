// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/note/edit.dart';
import 'package:flutter_application_1/component/crud.dart';
import 'package:flutter_application_1/constant/linkapi.dart';
import 'package:flutter_application_1/component/cardnote.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/notemodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Crud crud = Crud();
  getNotes() async {
    var response = await crud
        .postRequast(linkView, {"id": sharedPreferences.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${sharedPreferences.getString("username")}"),
        actions: [
          IconButton(
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'faile') {
                    return const Center(child: Text("no notes"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return CardNotes(
                        onDelete: () async {
                          var response = await crud.postRequast(linkDelete, {
                            "id":
                                snapshot.data['data'][i]["notes_id"].toString(),
                            "imagename": snapshot.data['data'][i]["notes_image"]
                                .toString()
                          });
                          if (response['status'] == "success") {
                            Navigator.of(context).pushReplacementNamed("home");
                          } else {}
                        },
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditNote(
                                notes: snapshot.data['data'][i],
                              ),
                            ),
                          );
                        },
                        noteModel: NoteModel.fromJson(snapshot.data['data'][i]),
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading..."));
                }
                return const Center(child: Text("No Note to display"));
              },
            )
          ],
        ),
      ),
    );
  }
}
