
import 'package:flutter/material.dart';


class CustomizedPopScope extends StatelessWidget {
  final Widget child;
  final void Function()? yesPressed;
  final void Function()? noPressed;
  final String? text;

  const CustomizedPopScope(
      {Key? key, required this.child,  this.text, this.yesPressed, this.noPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: child,
        onWillPop: () async {
          return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(text!),
              actions: [
                TextButton(
                  onPressed:yesPressed,
                    child: Text('Yes')),
                TextButton(
                    onPressed:noPressed,
                    child: Text('No')),
              ],
            ),
          ));
        });
  }
}
