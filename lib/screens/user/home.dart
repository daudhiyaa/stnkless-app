import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stnkless/components/button/button.dart';
import 'package:stnkless/components/snackbar.dart';
import 'package:stnkless/constants/color.dart';
import 'package:stnkless/constants/data.dart';
import 'package:stnkless/screens/user/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _search = TextEditingController();

  List<List<dynamic>> filteredCardData = [];

  User? user;
  String uid = '';
  Map<String, dynamic>? userData;
  String nama = "", email = "";
  int countData = 0;
  dynamic ref;
  String? imageUrl;

  Future<DocumentSnapshot> getUserDocument(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot;
  }

  Future<void> fetchUserData(String uid) async {
    DocumentSnapshot snapshot = await getUserDocument(uid);
    if (snapshot.exists) {
      userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        nama = userData!['nama'];
        email = userData!['email'];
        countData = userData!['countData'];
      }
      setState(() {});
    } else {
      if (mounted) {
        final snackBar = customSnackBar('Document does not exist');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> getDataFromStorage() async {
    try {
      imageUrl = await ref.getDownloadURL();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    setState(() {});
    fetchUserData(uid);

    filteredCardData.addAll(dummyCardData);
    super.initState();
  }

  void _filteringData(String query) {
    filteredCardData.clear();
    if (query.isEmpty) {
      filteredCardData.addAll(dummyCardData);
    } else {
      for (var data in dummyCardData) {
        if (data[0].toLowerCase().contains(query.toLowerCase())) {
          filteredCardData.add(data);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "STNKLess.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: maxHeight * 0.005),
                  TextField(
                    controller: _search,
                    onChanged: (query) {
                      _filteringData(query);
                    },
                    style: const TextStyle(fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: const TextStyle(fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      suffixIcon: const Icon(CupertinoIcons.search),
                    ),
                  ),
                  SizedBox(height: maxHeight * 0.015),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: filteredCardData.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return index < filteredCardData.length
                            ? GestureDetector(
                                onTap: () {
                                  // handle ontap
                                },
                                child: HomeScreenCard(
                                  filteredCardData: filteredCardData,
                                  index: index,
                                ),
                              )
                            : SizedBox(height: maxHeight * 0.08);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormPage(
                            uid: uid,
                            countData: countData,
                          ),
                        ),
                      );
                    },
                    title: "Tambah Data",
                    elevation: 5,
                  ),
                ),
                SizedBox(height: maxHeight * 0.015),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    required this.filteredCardData,
    required this.index,
  });

  final List<List> filteredCardData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              filteredCardData[index][0],
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            Text(
              filteredCardData[index][1],
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            Text(
              filteredCardData[index][2],
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
