import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/controller/db_handler.dart';
import 'package:note_app/controller/list_grid_provider.dart';
import 'package:note_app/controller/note_provider.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/view/screens/add_note.dart';
import 'package:note_app/view/screens/note_details.dart';
import 'package:note_app/view/widgets/empty_notes.dart';
import 'package:note_app/view/widgets/notes_list.dart';
import 'package:provider/provider.dart';

import '../widgets/NotesGrid.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        return(await showDialog(context: context, builder:(context)=> AlertDialog(
          title: Text('You realy want to Leave?'),
          actions: [
            TextButton(onPressed: () {
              SystemNavigator.pop();
            }, child: Text('Yes')),
            TextButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: Text('No')),
          ],
        ),));
      },
      child: Scaffold(
        backgroundColor: Colors.white70,

        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  //  IconButton(icon: Icon(Icons.delete), onPressed: () { Provider.of<NoteProvider>(context,listen: false).deleteAll(); },),
                    IconButton(
                      onPressed: () {
                        Provider.of<ListGridProvider>(context, listen: false)
                            .changeView();
                      },
                      icon: Provider.of<ListGridProvider>(context).isGrid == true
                          ? Icon(Icons.grid_view)
                          : Icon(Icons.list),
                      color: Colors.blue,
                    ),
                    IconButton(onPressed: (){
                      Provider.of<ListGridProvider>(context,listen: false).changeTheme();
                    }, icon: Icon(Icons.title))
                  ],
                ),
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(
                  height: 40,
                ),
                Provider.of<ListGridProvider>(context).isGrid==true?
                    NotesGrid():NotesList()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.note_add),
          onPressed: () {
            Navigator.pushNamed(context, AddNote.routeName);
          },
        ),
      ),
    );
  }
}
