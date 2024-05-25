import 'package:flutter/material.dart';

void ShowSnackBar (BuildContext context , String content){

   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}