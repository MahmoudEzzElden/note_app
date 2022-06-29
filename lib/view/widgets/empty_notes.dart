


import 'package:flutter/material.dart';
import 'package:path/path.dart';

class EmptyNotes extends StatelessWidget {
  static const routeName='EmptyNotes';
  const EmptyNotes({Key? key}) : super(key: key);
  Widget emptyNotes() {
    return Container(

      child: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/emptyNotes.jpg',
          height: 500,
            width: 400,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 50,),
        ],

      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return emptyNotes();
  }
}
