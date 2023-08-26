// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/coustomtextform.dart';
import 'package:flutter_application_1/component/crud.dart';
import 'package:flutter_application_1/component/valid.dart';
import 'package:flutter_application_1/constant/linkapi.dart';
import 'package:image_picker/image_picker.dart';

class EditNote extends StatefulWidget {
  final notes;
  const EditNote({super.key, this.notes});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  File? file;
  Crud crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  bool isLoading = false;

  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;
      if (file == null) {
        response = await crud.postRequast(linkEdit, {
          "title": title.text,
          "content": subTitle.text,
          "imagename": widget.notes['notes_image'].toString(),
          "id": widget.notes['notes_id'].toString(),
        });
      } else {
        response = await crud.postRequastWithFile(
          linkEdit,
          {
            "title": title.text,
            "content": subTitle.text,
            "imagename": widget.notes['notes_image'].toString(),
            "id": widget.notes['notes_id'].toString(),
          },
          file!,
        );
      }
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {}
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    subTitle.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditNote"),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextForm(
                      hint: "title",
                      controller: title,
                      valid: (val) {
                        return validInput(val!, 4, 20);
                      },
                    ),
                    CustomTextForm(
                      hint: "subtitle",
                      controller: subTitle,
                      valid: (val) {
                        return validInput(val!, 4, 60);
                      },
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SizedBox(
                            height: 100,
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      XFile? xFile = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      Navigator.of(context).pop();
                                      file = File(xFile!.path);
                                      file = File(xFile.path);
                                      if (file != null) {
                                      } else {}
                                      setState(() {});
                                    },
                                    child: const Column(
                                      children: [
                                        Icon(
                                          Icons.filter,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                        SizedBox(height: 5),
                                        Text("Gallory")
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      XFile? xFile = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      Navigator.of(context).pop();
                                      file = File(xFile!.path);
                                      if (file != null) {
                                      } else {}
                                      setState(() {});
                                    },
                                    child: const Column(
                                      children: [
                                        Icon(
                                          Icons.camera,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                        SizedBox(height: 5),
                                        Text("Camera")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      textColor: Colors.white,
                      color: file == null ? Colors.blue : Colors.green,
                      child: const Text("Upload image"),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await editNotes();
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: const Text("Update"),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
