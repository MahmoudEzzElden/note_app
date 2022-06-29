import 'package:flutter/material.dart';
import 'package:note_app/controller/list_grid_provider.dart';
import 'package:note_app/controller/note_provider.dart';
import 'package:note_app/view/screens/add_note.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:note_app/view/screens/note_details.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NoteProvider>(
        create: (context) => NoteProvider()),
    ChangeNotifierProvider<ListGridProvider>(
        create: (context) => ListGridProvider()),
  ],
    child: const MyApp(),),
      );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
          AddNote.routeName:(context)=>AddNote(),
          NoteDetails.routeName:(context)=>NoteDetails(),
        HomeScreen.routeName:(context)=>HomeScreen(),
      },
      theme: Provider.of<ListGridProvider>(context).darkTheme==true? ThemeData.dark(): ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

