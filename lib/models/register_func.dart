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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      if (mounted) {
        createUserDetails(context, mounted, uid, usn, email, password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      final snackBar = customSnackBar(e.message!);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } else {
    final snackBar = customSnackBar('Password tidak terkonfirmasi');
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
