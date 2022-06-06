


import 'package:flutter/material.dart';

class EmptyNotes extends StatelessWidget {
  static const routeName='EmptyNotes';
  const EmptyNotes({Key? key}) : super(key: key);
  Widget emptyNotes() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/emptyNotes.jpg',
          height: 400,
            width: 250,
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
