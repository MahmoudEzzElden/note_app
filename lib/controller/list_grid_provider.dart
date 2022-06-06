import 'package:flutter/cupertino.dart';

class ListGridProvider with ChangeNotifier{
  bool isGrid=true;
  bool darkTheme=true;
  changeView(){
    isGrid=!isGrid;
    notifyListeners();
  }
  changeTheme(){
    darkTheme=!darkTheme;
    notifyListeners();
  }
}