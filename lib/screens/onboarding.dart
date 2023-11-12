import 'package:flutter/material.dart';

import 'package:stnkless/components/button/button.dart';
import 'package:stnkless/components/stnkless_logo.dart';
import 'package:stnkless/screens/auth/login.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: maxHeight * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const STNKLessLogo(
                    stnkLessSize: 35,
                    byITSCampusSize: 14,
                  ),
                  SizedBox(
                    height: maxHeight * 0.07,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'STNKLess. ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Aplikasi Berbasis Machine Learning Sebagai Otomatisasi Portal Parkir Guna Mengurangi Kasus Pencurian Motor',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              title: 'Lanjutkan',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
