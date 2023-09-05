import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData? iconData;
  final Color backgroundColor;

  const SquareButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.iconData,
    this.backgroundColor = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null) ...[
            Icon(iconData),
            const SizedBox(width: 8),
          ],
          Text(
            buttonText,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
