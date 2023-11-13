import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stnkless/constants/color.dart';

import 'package:stnkless/screens/admin/admin.dart';
import 'package:stnkless/screens/profile.dart';
import 'package:stnkless/screens/user/home.dart';

class BaseScreen extends StatefulWidget {
  final bool isAdmin;
  const BaseScreen({super.key, this.isAdmin = false});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const AdminPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    pages = widget.isAdmin
        ? [const AdminPage(), const ProfilePage()]
        : [const HomePage(), const ProfilePage()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                widget.isAdmin ? Icons.security : CupertinoIcons.house_fill),
            label: widget.isAdmin ? 'Admin' : 'Home',
            tooltip: widget.isAdmin ? "Admin Page" : "Home Page",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle),
            label: 'Profile',
            tooltip: "Profile Page",
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: darkBlue,
        unselectedItemColor: Colors.grey.shade500,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0,
      ),
    );
  }
}
