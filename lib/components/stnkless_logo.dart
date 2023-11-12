import 'package:flutter/material.dart';

class STNKLessLogo extends StatelessWidget {
  final double stnkLessSize;
  final double byITSCampusSize;
  final MainAxisAlignment mainAxisAlignment;

  const STNKLessLogo({
    super.key,
    required this.stnkLessSize,
    required this.byITSCampusSize,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'STNKLess.',
          style: TextStyle(
            fontSize: stnkLessSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'By ITS Campus',
          style: TextStyle(
            fontSize: byITSCampusSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
