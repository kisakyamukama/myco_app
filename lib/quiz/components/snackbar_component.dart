import 'package:flutter/material.dart';

 mycoSnackBar(BuildContext ctx, String message) {
   SnackBar snackBar = SnackBar(content:Text(message));
                    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  
}