import 'package:flutter/cupertino.dart';
import '../model/note_model.dart';
import '../services/db_handler.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> list = [];
  Future<List<NoteModel>> getNotes() async {
    list = await DataBaseHandler.instance.getAllNotes();
    notifyListeners();
    return list;
  }

  Future<void> addNote(NoteModel noteModel) async {
    await DataBaseHandler.instance
        .createNote(noteModel)
        .then((value) => getNotes());
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await DataBaseHandler.instance.deleteNote(id).then((value) => getNotes());
    notifyListeners();
  }

  Future<void> updateNote(NoteModel noteModel) async {
    await DataBaseHandler.instance.updateNote(noteModel);
    notifyListeners();
  }


  // Future<void> deleteNoteTable() async{
  //   await DataBaseHandler.instance.deleteTable().then((value) => getNotes());
  //   notifyListeners();
  // }

  Future <void> deleteAllData() async{
    await DataBaseHandler.instance.deleteAllData().then((value) => getNotes());
    notifyListeners();
  }
}
