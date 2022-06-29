import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/controller/list_grid_provider.dart';
import 'package:note_app/view/screens/add_note.dart';
import 'package:note_app/view/widgets/notes_list.dart';
import 'package:note_app/view/widgets/pop_scope.dart';
import 'package:provider/provider.dart';
import '../../controller/note_provider.dart';
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
    return CustomizedPopScope(
      text: 'You Really Want To Leave?',
      yesPressed: (){
        SystemNavigator.pop();
      },
      noPressed: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    Text('You want to delete all your notes?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<NoteProvider>(context,listen: false).deleteAllData();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }, child: Text('No'))
                                ],
                              );
                            });
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<ListGridProvider>(context, listen: false)
                            .changeView();
                      },
                      icon:
                          Provider.of<ListGridProvider>(context).isGrid == true
                              ? Icon(Icons.grid_view)
                              : Icon(Icons.list),
                      color: Colors.blue,
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<ListGridProvider>(context, listen: false)
                              .changeTheme();
                        },
                        icon: Icon(Icons.title))
                  ],
                ),
                Text(
                  'Notes',
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(
                  height: 40,
                ),
                Provider.of<ListGridProvider>(context).isGrid == true
                    ? NotesGrid()
                    : NotesList()
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
