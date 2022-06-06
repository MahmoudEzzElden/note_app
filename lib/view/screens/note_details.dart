import 'package:flutter/material.dart';
import 'package:note_app/controller/db_handler.dart';
import 'package:note_app/controller/note_provider.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:provider/provider.dart';


class NoteDetails extends StatefulWidget {
  static const String routeName = 'NoteDetails';

  const NoteDetails({Key? key}) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  TextEditingController bodyController= TextEditingController();
  TextEditingController titleController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    List list=ModalRoute.of(context)?.settings.arguments as List;
    titleController.text=list[1];
    bodyController.text=list[2];
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0.1,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            showDialog(context: context, builder:(context)=> AlertDialog(
              title: Text('You want to Save Changes?'),
              actions: [
                TextButton(onPressed: () {
                  Provider.of<NoteProvider>(context,listen: false).updateNote(NoteModel(id: list[0],title: titleController.text,body: bodyController.text,creationTime: DateTime.now())).then((value) =>Navigator.pushNamed(context, HomeScreen.routeName));
                }, child: Text('Yes')),
                TextButton(onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }, child: Text('No')),
              ],
            ));

          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                controller: titleController,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // hintText: '${list[1]}',
                  // hintStyle:
                  // TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                  // hintText: '${list[2]}',
                  // hintMaxLines: 40,
                  // hintStyle: TextStyle(
                  //   fontSize: 22,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  @override
  void dispose() {
    bodyController.dispose();
    titleController.dispose();
    super.dispose();
  }

}
