
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controller/note_provider.dart';
import 'package:provider/provider.dart';
import '../../model/note_model.dart';
import '../screens/note_details.dart';
import 'empty_notes.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NoteModel>>(
        future: Provider.of<NoteProvider>(context,listen: false).getNotes(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Provider.of<NoteProvider>(context).list.isNotEmpty?
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              GridView.builder(
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  shrinkWrap: true,
                  itemCount: Provider.of<NoteProvider>(context).list.length,
                  itemBuilder: (context, index) {
                    return  Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),

                        child: Dismissible(
                          key:ObjectKey( Provider.of<NoteProvider>(context,listen: false).list[index]),
                          direction: DismissDirection.up,
                          onDismissed:(direction) {
                            Provider.of<NoteProvider>(context,listen: false).deleteNote(
                                Provider.of<NoteProvider>(context,listen: false).list[index].id!
                            );
                          },
                          background: Container(alignment: Alignment.centerLeft,
                            color: Colors.redAccent,
                            child: Icon(Icons.delete_forever),
                          ),
                          child: GestureDetector(
                              onTap: () {
                              Map arguments={
                               'id': Provider.of<NoteProvider>(context,listen: false).list[index].id,
                               'title': Provider.of<NoteProvider>(context,listen: false).list[index].title,
                              'body':  Provider.of<NoteProvider>(context,listen: false).list[index].body
                              };
                                Navigator.pushNamed(context,
                                    NoteDetails.routeName,
                                    arguments: arguments);
                              },
                              onLongPress: () {
                                HapticFeedback.vibrate();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(


                                    content: IconButton(
                                        onPressed: () {
                                          Provider.of<NoteProvider>(context,listen: false).deleteNote(
                                              Provider.of<NoteProvider>(context,listen: false).list[index].id!
                                          );
                                          ScaffoldMessenger
                                              .of(context)
                                              .hideCurrentSnackBar();
                                        },
                                        icon: Icon(
                                            Icons.delete,color: Colors.grey,)),
                                  ),
                                );
                              },
                              child:GridTile(
                                header: Text(
                                  Provider.of<NoteProvider>(context)
                                      .list[index].title!,
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 26),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      top: 75),
                                  child: Text(
                                    Provider.of<NoteProvider>(context)
                                        .list[index].body!,
                                    style: TextStyle(
                                        fontSize: 20),
                                  ),

                                ),
                                footer: Text(DateFormat.yMEd().add_jms().format(Provider.of<NoteProvider>(context)
                                    .list[index].creationTime!).toString()),
                              )
                          ),
                        ));

                  }),
            ],
          ):EmptyNotes()
              : snapshot.hasError
              ? Center(
            child: Text(
              snapshot.error.toString(),
              style: TextStyle(fontSize: 20),
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        });


  }
}
