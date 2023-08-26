// ignore_for_file: unnecessary_string_interpolations, unnecessary_null_comparison, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/linkapi.dart';
import 'package:flutter_application_1/models/notemodel.dart';

class CardNotes extends StatelessWidget {
  final void Function()? onTap;
  final NoteModel noteModel;
  final void Function()? onDelete;
  const CardNotes({
    super.key,
    required this.onTap,
    required this.noteModel,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkImageRoot/${noteModel.notesImage}",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${noteModel.notesTitle}"),
                subtitle: Text("${noteModel.notesContent}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
