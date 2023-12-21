import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'package:stnkless/components/button/button.dart';
import 'package:stnkless/components/textfield/editprofile_textfield.dart';
import 'package:stnkless/screens/auth/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  List<String> listLabelText = [
    'UID',
    'Email',
  ];

  final List<TextEditingController> _listTextEditingController = [
    TextEditingController(),
    TextEditingController(),
  ];

  final ImagePicker imagePicker = ImagePicker();
  dynamic ref;

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

    var file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) return;

    await _uploadFile(file.path);
  }

  Future _uploadFile(String path) async {
    final metadata = storage.SettableMetadata(contentType: 'image/jpg');
    final res = await ref.putFile(File(path), metadata);
    final fileUrl = await res.ref.getDownloadURL();

    setState(() {
      // widget.imageUrl = fileUrl;
    });
  }

  void setData(String nama, String email) {
    _listTextEditingController[0].text = nama;
    _listTextEditingController[1].text = email;
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user!.email!;
    setData(user.uid, user.email!);
    ref = storage.FirebaseStorage.instance.ref().child(email).child("profile");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: maxHeight * 0.05),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const CircleAvatar(
                        radius: 56,
                        backgroundImage: NetworkImage(
                            'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 70,
                      child: GestureDetector(
                        onTap: () {
                          _selectPhoto(const Text("Pick an image"));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 3),
                                blurRadius: 8,
                              )
                            ],
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: maxHeight * 0.02),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _listTextEditingController.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return EditProfileTextField(
                      textEditingController: _listTextEditingController[idx],
                      labelText: listLabelText[idx],
                    );
                  },
                ),
                SizedBox(height: maxHeight * 0.02),
                CustomButton(
                  onPressed: () {
                    // updateProfile();
                  },
                  title: 'Simpan',
                ),
                SizedBox(height: maxHeight * 0.02),
                CustomButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  title: "Keluar",
                  textColor: Colors.white,
                  buttonColor: const Color.fromARGB(255, 203, 22, 9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
