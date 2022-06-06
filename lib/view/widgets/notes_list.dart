
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controller/note_provider.dart';
import 'package:provider/provider.dart';

import '../../controller/db_handler.dart';
import '../../model/note_model.dart';
import '../screens/note_details.dart';
import 'empty_notes.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return FutureBuilder<List<NoteModel>>(
            future: Provider.of<NoteProvider>(context,listen: false).getNotes(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ListView.builder(
                      physics: ScrollPhysics(),

                      shrinkWrap: true,
                      itemCount: Provider.of<NoteProvider>(context).list.length,
                      itemBuilder: (context, index) {
                        return Provider.of<NoteProvider>(context).list.isNotEmpty
                            ? GestureDetector(
                              onTap: () {
                                List args = [
                                  Provider.of<NoteProvider>(context,listen: false).list[index].id,
                                  Provider.of<NoteProvider>(context,listen: false).list[index].title,
                                  Provider.of<NoteProvider>(context,listen: false).list[index].body
                                ];

                                Navigator.pushNamed(context,
                                    NoteDetails.routeName,
                                    arguments: args);
                              },
                              onLongPress: () {
                                HapticFeedback.vibrate();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                    Colors.white,
                                    content: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Provider.of<NoteProvider>(context,listen: false).deleteNote(
                                                  Provider.of<NoteProvider>(context,listen: false).list[index].id!
                                              );
                                              ScaffoldMessenger
                                                  .of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                            icon: Icon(
                                                Icons.delete)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.share)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      minVerticalPadding: 5,
                                      tileColor: Colors.lightBlue,

                                      trailing:Text(DateFormat.yMEd().add_jms().format(Provider.of<NoteProvider>(context)
                                          .list[index].creationTime!).toString()) ,
                                      title: Text(
                                        Provider.of<NoteProvider>(context)
                                            .list[index].title!,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      subtitle:
                                      Text(
                                        Provider.of<NoteProvider>(context)
                                            .list[index].body!,
                                        style: TextStyle(
                                            fontSize: 18),
                                      ),

                                    ),
                                  )
                            )
                            : EmptyNotes();
                      }),
                ],
              )
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
