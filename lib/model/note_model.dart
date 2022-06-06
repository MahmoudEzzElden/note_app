
import 'package:note_app/model/constants.dart';

class NoteModel{
final int? id;
final String? title;
final String? body;
final DateTime? creationTime;


const NoteModel({this.id, this.title, this.body,this.creationTime});

Map<String,dynamic> toMap(){
  return {noteTitle: title,
    noteBody:body,
    createdTime:creationTime!.toIso8601String(),
  };
}
//
  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
      id:map[noteID],
      title:map[noteTitle],
      body:map[noteBody],
      creationTime: DateTime.parse(map[createdTime].toString()),

    );
  }

}
