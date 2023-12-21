import 'package:flutter/material.dart';

import 'package:stnkless/components/button/button.dart';
import 'package:stnkless/components/button/login_with_google.dart';
import 'package:stnkless/components/stnkless_logo.dart';
import 'package:stnkless/components/textfield/textfield.dart';
import 'package:stnkless/constants/color.dart';
import 'package:stnkless/constants/constants.dart';
import 'package:stnkless/models/login_func.dart';
import 'package:stnkless/screens/auth/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: paddingAllPages),
          children: [
            SizedBox(height: maxHeight * 0.05),
            SizedBox(
              height: maxHeight * 0.23,
              child: const Center(
                child: STNKLessLogo(
                  stnkLessSize: 32,
                  byITSCampusSize: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            const Text(
              'Selamat datang',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Mohon untuk mengisi kelengkapan data dibawah ini',
              style: TextStyle(
                fontSize: 10.5,
              ),
            ),
            const SizedBox(height: 32.0),
            CustomTextField(
              textEditingController: _email,
              icon: Icons.email,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              textEditingController: _password,
              labelText: "Password",
              icon: Icons.lock,
              onChanged: (value) {},
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                color: darkBlue,
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
              obsecureText: showPassword,
              enableSuggestion: false,
              autoCorrect: false,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // handle onpress
                },
                child: const Text(
                  'Lupa Password?',
                  style: TextStyle(
                    color: primaryPurple,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            CustomButton(
              title: 'Masuk',
              onPressed: () {
                login(context, mounted, _email.text, _password.text);
              },
            ),
            const SizedBox(height: 10.0),
            const ButtonLoginWithGoogle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum memiliki akun?",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    ),
                  },
                  child: const Text(
                    "Daftar.",
                    style: TextStyle(
                      color: primaryPurple,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
