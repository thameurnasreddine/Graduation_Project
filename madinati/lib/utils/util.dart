import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void ShowSnackBar (BuildContext context , String content){

   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}