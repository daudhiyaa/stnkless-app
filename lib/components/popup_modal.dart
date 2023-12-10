import 'package:flutter/material.dart';

void showPopupModal(
  BuildContext context,
  IconData icon,
  String text,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Icon(
              icon,
              size: 90,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
            )
          ],
        ),
        actions: [
          TextButton(
            child: const Text(
              'Tutup',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
