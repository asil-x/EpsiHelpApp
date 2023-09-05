import 'package:flutter/material.dart';

import '../layout_utils.dart';

class RoundCenteredTextField extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;
  final TextEditingController controller;

  const RoundCenteredTextField(this.hint, this.onChanged, this.controller,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        enabledBorder: roundPurpleBorder(30),
        focusedBorder: roundPurpleBorder(30),
        hintText: hint,
      ),
      textAlign: TextAlign.center,
      onChanged: onChanged,
    );
  }
}
