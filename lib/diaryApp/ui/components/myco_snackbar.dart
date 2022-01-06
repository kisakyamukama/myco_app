 import 'package:flutter/material.dart';

 mycoSnackBar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(content: Text(message));
     return  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}