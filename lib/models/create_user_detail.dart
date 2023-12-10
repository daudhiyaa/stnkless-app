import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:stnkless/components/snackbar.dart';

Future createUserDetails(
  BuildContext context,
  bool mounted,
  String uid,
  String nama,
  String email,
  String password,
) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set(
    {
      'nama': nama,
      'email': email,
      'password': password,
      'countData': 0,
      'listData': [],
    },
  );

  final imageBytes = await rootBundle.load('assets/images/profile.jpg');
  final metadata = storage.SettableMetadata(contentType: 'image/jpg');

  try {
    final ref =
        storage.FirebaseStorage.instance.ref().child(uid).child("profile");
    final uploadTask = ref.putData(imageBytes.buffer.asUint8List(), metadata);
    final snapshot = await uploadTask.whenComplete(() => null);

    final downloadURL = await snapshot.ref.getDownloadURL();
    // print('ini downloadURL $downloadURL');
  } catch (e) {
    final snackBar = customSnackBar('Error uploading image: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
