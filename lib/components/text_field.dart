import 'package:flutter/cupertino.dart';

class CustomCupertinoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData prefixIcon;
  final Function() onClearPressed;
  final String? errorText; // New property for error messages

  const CustomCupertinoTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.prefixIcon,
    required this.onClearPressed,
    this.errorText, // Initialize it with null by default
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          placeholder: placeholder,
          controller: controller,
          obscureText: placeholder == 'Password',
          enableSuggestions: placeholder != 'Password',
          prefix: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              prefixIcon,
              color: CupertinoColors.systemGrey,
              size: 28,
            ),
          ),
          suffix: CupertinoButton(
            onPressed: onClearPressed,
            child: const Icon(
              CupertinoIcons.clear_thick_circled,
              size: 28,
            ),
          ),
          suffixMode: OverlayVisibilityMode.editing,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.systemRed,
                fontSize: 12,
              ),
              child: Text(errorText!),
            ),
          ),
      ],
    );
  }
}
