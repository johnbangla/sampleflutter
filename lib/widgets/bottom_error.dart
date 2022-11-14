import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../localization/Language/languages.dart';

class BottomError extends StatelessWidget {
  final String message;

  BottomError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        '${Languages.of(context)!.otpValidation}',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
  }
}
