import 'package:flutter/cupertino.dart';

class CustomCupertinoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData prefixIcon;
  final Function() onClearPressed;

  CustomCupertinoTextField({
    required this.controller,
    required this.placeholder,
    required this.prefixIcon,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
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
        child: Icon(
          CupertinoIcons.clear_thick_circled,
          size: 28,
        ),
        onPressed: onClearPressed,
      ),
      suffixMode: OverlayVisibilityMode.editing,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.lightBackgroundGray,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
