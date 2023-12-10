import 'package:flutter/material.dart';

import 'package:stnkless/components/button/button.dart';
import 'package:stnkless/components/button/login_with_google.dart';
import 'package:stnkless/components/snackbar.dart';
import 'package:stnkless/components/stnkless_logo.dart';
import 'package:stnkless/components/textfield.dart';
import 'package:stnkless/constants/color.dart';
import 'package:stnkless/constants/constants.dart';
import 'package:stnkless/models/register_func.dart';
import 'package:stnkless/screens/auth/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usn = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  bool showPassword = true, showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: paddingAllPages),
          children: [
            SizedBox(
              height: maxHeight * 0.2,
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
              textEditingController: _usn,
              icon: Icons.person,
              labelText: "Nama",
              onChanged: (value) {},
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              textEditingController: _email,
              icon: Icons.email,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
            ),
            const SizedBox(height: 10.0),
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
            const SizedBox(height: 10.0),
            CustomTextField(
              textEditingController: _confirmpassword,
              labelText: "Confirm Password",
              icon: Icons.lock,
              onChanged: (value) {},
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                color: darkBlue,
                onPressed: () {
                  setState(() {
                    showConfirmPassword = !showConfirmPassword;
                  });
                },
              ),
              obsecureText: showConfirmPassword,
              enableSuggestion: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 32.0),
            CustomButton(
              title: 'Daftar',
              onPressed: () {
                if (_usn.text.isEmpty ||
                    _email.text.isEmpty ||
                    _password.text.isEmpty ||
                    _confirmpassword.text.isEmpty) {
                  final snackBar = customSnackBar('Mohon isi semua field');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  signUp(
                    context,
                    mounted,
                    _usn.text,
                    _email.text,
                    _password.text,
                    _confirmpassword.text,
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            const ButtonLoginWithGoogle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah memiliki akun?",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  },
                  child: const Text(
                    "Masuk.",
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
