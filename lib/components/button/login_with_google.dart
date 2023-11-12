import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stnkless/constants/color.dart';

class ButtonLoginWithGoogle extends StatelessWidget {
  const ButtonLoginWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle button press
      },
      icon: const FaIcon(FontAwesomeIcons.google, color: darkBlue),
      label: const Text(
        'Masuk menggunakan Google',
        style: TextStyle(color: darkBlue, fontSize: 13),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            return lightBlue;
          },
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 12.0),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
