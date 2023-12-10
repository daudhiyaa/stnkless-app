import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:stnkless/components/button/button.dart';
import 'package:stnkless/components/popup_modal.dart';
import 'package:stnkless/components/snackbar.dart';
import 'package:stnkless/constants/color.dart';
import 'package:stnkless/constants/data.dart';
import 'package:stnkless/screens/user/home.dart';

class FormPage extends StatefulWidget {
  final String uid;
  final int countData;

  const FormPage({super.key, required this.uid, required this.countData});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final ImagePicker imagePicker = ImagePicker();
  dynamic ref;

  Map<String, String> imagePath = {
    listDirectoryName[0]: "",
    listDirectoryName[1]: "",
    listDirectoryName[2]: "",
    listDirectoryName[3]: "",
    listDirectoryName[4]: "",
    listDirectoryName[5]: "",
    listDirectoryName[6]: "",
  };

  Future<void> saveData() async {
    if (textFieldData[0]["controller"].text.isEmpty ||
        textFieldData[1]["controller"].text.isEmpty) {
      final snackBar = customSnackBar('Nama dan Plat Nomor tidak boleh kosong');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else if (imagePath[listDirectoryName[0]] == "" ||
        imagePath[listDirectoryName[1]] == "" ||
        imagePath[listDirectoryName[2]] == "" ||
        imagePath[listDirectoryName[3]] == "" ||
        imagePath[listDirectoryName[4]] == "" ||
        imagePath[listDirectoryName[5]] == "" ||
        imagePath[listDirectoryName[6]] == "") {
      final snackBar = customSnackBar('Semua foto harus diisi');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    Map tempListData = {};
    tempListData['${widget.countData}'] = {
      'nama': textFieldData[0]["controller"].text,
      'plat_nomor': textFieldData[1]["controller"].text,
    };

    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
        'countData': widget.countData + 1,
        'listData': tempListData,
      }, SetOptions(merge: true));

      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
    } on FirebaseException catch (e) {
      final snackBar = customSnackBar(e.message!);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future _selectPhoto(Widget title, int index) async {
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
                          _pickImage(
                            ImageSource.camera,
                            listDirectoryName[index],
                          );
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
                          _pickImage(
                            ImageSource.gallery,
                            listDirectoryName[index],
                          );
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

  Future _pickImage(ImageSource source, String directoryName) async {
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile == null) return;

    var file = await ImageCropper().cropImage(sourcePath: pickedFile.path);
    if (file == null) return;

    await _uploadFile(file.path, directoryName);
  }

  Future _uploadFile(String path, String directoryName) async {
    final metadata = storage.SettableMetadata(contentType: 'image/jpg');
    ref = storage.FirebaseStorage.instance
        .ref()
        .child(widget.uid)
        .child(widget.countData.toString())
        .child(directoryName);
    final res = await ref.putFile(File(path), metadata);
    final fileUrl = await res.ref.getDownloadURL();

    setState(() {
      imagePath[directoryName] = fileUrl;
    });

    if (mounted) {
      showPopupModal(
        context,
        CupertinoIcons.checkmark_alt_circle,
        "$directoryName Berhasil Diupload",
      );
    }
  }

  @override
  void initState() {
    setState(() {});
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: textFieldData.length + cardData.length + 1,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: textFieldData[index]["controller"],
                              style: const TextStyle(fontFamily: 'Poppins'),
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
                      : index < textFieldData.length + cardData.length
                          ? GestureDetector(
                              onTap: () {
                                _selectPhoto(
                                  cardData[index - textFieldData.length][1],
                                  index - textFieldData.length,
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 25),
                                color: imagePath[listDirectoryName[
                                            index - textFieldData.length]] ==
                                        ""
                                    ? Colors.blueGrey
                                    : Colors.white,
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
                            )
                          : CustomButton(
                              onPressed: saveData,
                              title: "Simpan Data",
                              buttonColor: darkBlue,
                              textColor: Colors.white,
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
