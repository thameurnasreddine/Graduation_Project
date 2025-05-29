import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String actionMessage;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.actionMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title, style:const TextStyle(
                                
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Cairo',
                              ),),
      content: Text(message,style:const TextStyle(
                                
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo',
                              ),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(actionMessage,style:const TextStyle(
                                
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo',
                              ),),
        ),
      ],
    );
  }
}
