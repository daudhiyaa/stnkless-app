import 'package:flutter/material.dart';

SnackBar customSnackBar(String error) {
  return SnackBar(
    content: Text(error),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blueGrey,
    elevation: 6.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}
