import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stnkless/components/snackbar.dart';
import 'package:stnkless/screens/base.dart';

Future login(
  BuildContext context,
  bool mounted,
  String email,
  String password,
) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    final snackBar = customSnackBar(e.code);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
