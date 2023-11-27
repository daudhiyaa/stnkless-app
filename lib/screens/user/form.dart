import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:stnkless/components/snackbar.dart';

class FormPage extends StatefulWidget {
  final String uid;
  const FormPage({super.key, required this.uid});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final ImagePicker imagePicker = ImagePicker();
  String imagePath = '';

  List<Map<String, dynamic>> textFieldData = [
    {
      "controller": TextEditingController(),
      "label": "Nama",
    },
    {
      "controller": TextEditingController(),
      "label": "Plat Nomor (tanpa spasi)",
    },
  ];
  List<List<Widget>> cardData = const [
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.redAccent,
      ),
      Text('Foto Wajah'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.amberAccent,
      ),
      Text('Foto STNK'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.greenAccent,
      ),
      Text('Foto Wajah + STNK'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.blueAccent,
      ),
      Text('Foto Plat Nomor'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.pink,
      ),
      Text('Foto Motor (tampak depan)'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.orangeAccent,
      ),
      Text('Foto Memakai Helm'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
    [
      Icon(
        CupertinoIcons.photo,
        color: Colors.purpleAccent,
      ),
      Text('Foto Diatas Motor'),
      Icon(CupertinoIcons.checkmark_alt_circle)
    ],
  ];

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update(
        {
          // count: count+1
        },
      );

      setState(() {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomePage(),
        //   ),
        // );
      });
    } on FirebaseException catch (e) {
      final snackBar = customSnackBar(e.message!);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future _selectPhoto(Widget title) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) => BottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        onClosing: () {},
        builder: (context) => SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              title,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _pickImage(ImageSource.camera);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12), // Adjust as needed
                        ),
                        child: const Icon(Icons.camera),
                      ),
                      const Text('Camera'),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _pickImage(ImageSource.gallery);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12), // Adjust as needed
                        ),
                        child: const Icon(Icons.filter),
                      ),
                      const Text('Gallery'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile == null) return;

    var file = await ImageCropper().cropImage(sourcePath: pickedFile.path);
    if (file == null) return;

    // await _uploadFile(file.path);
  }

  dynamic ref;
  Future _uploadFile(String path) async {
    final res = await ref.putFile(File(path));
    final fileUrl = await res.ref.getDownloadURL();
    setState(() {
      imagePath = fileUrl;
    });
  }

  @override
  void initState() {
    ref = storage.FirebaseStorage.instance
        .ref()
        .child("images")
        .child(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            CupertinoIcons.chevron_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Tambahkan Data Anda',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: textFieldData.length + cardData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return index < 2
                        ? Card(
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: textFieldData[index]["controller"],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: textFieldData[index]["label"],
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _selectPhoto(
                                  cardData[index - textFieldData.length][1]);
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 25),
                              color: Colors.white,
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:
                                      cardData[index - textFieldData.length],
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
