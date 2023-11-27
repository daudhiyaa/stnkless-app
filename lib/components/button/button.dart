import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final double elevation;
  final Color buttonColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.elevation = 0,
    this.buttonColor = Colors.amber,
    this.textColor = const Color(0xFF362FD9),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(elevation),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return buttonColor.withAlpha(100);
              }
              return buttonColor;
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
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
