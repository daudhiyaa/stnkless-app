import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stnkless/components/snackbar.dart';
import 'package:stnkless/models/create_user_detail.dart';
import 'package:stnkless/screens/auth/login.dart';

bool passwordConfirmed(String password, String confirmPassword) {
  return password == confirmPassword;
}

Future signUp(
  BuildContext context,
  bool mounted,
  String usn,
  String email,
  String password,
  String confirmPassword,
) async {
  if (passwordConfirmed(password, confirmPassword)) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (mounted) {
        createUserDetails(context, mounted, usn, email, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      final snackBar = customSnackBar(e.code);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } else {
    final snackBar = customSnackBar('Password tidak terkonfirmasi');
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
