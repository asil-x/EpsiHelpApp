import 'package:flutter/material.dart';

import '../colors.dart';

class RoundCornerButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData? iconData;

  const RoundCornerButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        backgroundColor: kPurple,
      ),
      onPressed: onPressed,
      child: iconData != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData),
                const SizedBox(width: 8),
                Text(buttonText),
              ],
            )
          : Text(buttonText),
    );
  }
}
