import 'package:flutter/material.dart';
import 'package:stnkless/constants/color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color iconColor;
  final Color labelTextColor;
  final TextEditingController textEditingController;
  final double fontSize;
  final Widget? suffixIcon;
  final bool obsecureText, enableSuggestion, autoCorrect;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.textEditingController,
    required this.icon,
    this.iconColor = darkBlue,
    this.labelTextColor = darkBlue,
    this.fontSize = 15,
    this.suffixIcon,
    this.obsecureText = false,
    this.enableSuggestion = true,
    this.autoCorrect = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightBlue,
      ),
      child: TextField(
        controller: textEditingController,
        obscureText: obsecureText,
        enableSuggestions: enableSuggestion,
        autocorrect: autoCorrect,
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscuringCharacter: "*",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: darkBlue,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelTextColor,
            fontSize: fontSize,
            fontFamily: 'Poppins',
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
