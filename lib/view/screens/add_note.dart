import 'package:flutter/material.dart';
import 'package:note_app/controller/db_handler.dart';
import 'package:note_app/controller/note_provider.dart';
import 'package:note_app/model/note_model.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  static const String routeName = 'AddNote';

  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  Future<void> addNOte(NoteModel noteModel) async {
    await DataBaseHandler.instance.createNote(noteModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.1,
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Note",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            (titleController.text.isEmpty && bodyController.text.isEmpty)
                ? Navigator.pop(context)
                : Provider.of<NoteProvider>(context, listen: false)
                    .addNote(NoteModel(
                        title: titleController.text, body: bodyController.text,creationTime: DateTime.now()))
                    .then((value) => Navigator.pop(context));
            // DataBaseHandler.instance
            //     .createNote(NoteModel(
            //         title: titleController.text,
            //         body: bodyController.text,
            // )).then((value) => Navigator.pop(context));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                controller: titleController,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              TextFormField(
                style: TextStyle(fontSize: 22),
                maxLines: null,
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type Something..',
                  hintStyle: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
