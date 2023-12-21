import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required TextEditingController textEditingController,
    required this.labelText,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.black45,
              fontFamily: 'Poppins',
            ),
          ),
          style: const TextStyle(fontFamily: 'Poppins'),
          onSubmitted: (value) {
            _textEditingController.text = _textEditingController.text;
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
