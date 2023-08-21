import 'package:flutter/cupertino.dart';

class CustomCupertinoTextField extends FormField<String> {
  final TextEditingController controller;
  final String placeholder;
  final IconData prefixIcon;

  get value => controller.value.text;

  CustomCupertinoTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.prefixIcon,
    String errorText = '',
    bool enabled = true,
    EdgeInsets padding = const EdgeInsets.only(bottom: 15),
    FormFieldValidator? validator,
  }) : super(
          enabled: enabled,
          initialValue: controller.text,
          validator: validator,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoTextField(
                  enabled: enabled,
                  placeholder: placeholder,
                  controller: controller,
                  obscureText: placeholder == 'Password',
                  enableSuggestions: placeholder != 'Password',
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      prefixIcon,
                      color: CupertinoColors.systemGrey,
                      size: 28,
                    ),
                  ),
                  onChanged: (value) {
                      state.didChange(controller.value.text);
                  },
                  suffix: CupertinoButton(
                    onPressed: () => {
                      state.didChange(''),
                      controller.clear()
                    },
                    padding: const EdgeInsets.all(0),
                    child: const Icon(
                      CupertinoIcons.clear_thick_circled,
                      size: 20,
                    ),
                  ),
                  suffixMode: enabled ? OverlayVisibilityMode.editing : OverlayVisibilityMode.never,
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 4),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: CupertinoColors.systemRed,
                        fontSize: 12,
                      ),
                      child: Text(state.errorText!),
                    ),
                  ),
                Padding(padding: padding)
              ],
            );
          },
        );
}

// import 'package:flutter/cupertino.dart';
//
// class CustomCupertinoTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String placeholder;
//   final IconData prefixIcon;
//   final Function() onClearPressed;
//   final String? errorText;
//
//   const CustomCupertinoTextField({
//     Key? key,
//     required this.controller,
//     required this.placeholder,
//     required this.prefixIcon,
//     required this.onClearPressed,
//     this.errorText,
//   }) : super(key: key);
//
//   @override
//   _CustomCupertinoTextFieldState createState() =>
//       _CustomCupertinoTextFieldState();
// }
//
// class _CustomCupertinoTextFieldState extends State<CustomCupertinoTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CupertinoTextField(
//           placeholder: widget.placeholder,
//           controller: widget.controller,
//           obscureText: widget.placeholder == 'Password',
//           enableSuggestions: widget.placeholder != 'Password',
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: CupertinoColors.lightBackgroundGray,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           prefix: Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Icon(
//               widget.prefixIcon,
//               color: CupertinoColors.systemGrey,
//               size: 28,
//             ),
//           ),
//           suffix: CupertinoButton(
//             onPressed: widget.onClearPressed,
//             child: const Icon(
//               CupertinoIcons.clear_thick_circled,
//               size: 28,
//             ),
//           ),
//           suffixMode: OverlayVisibilityMode.editing,
//         ),
//         if (widget.errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(left: 16, top: 4),
//             child: DefaultTextStyle(
//               style: const TextStyle(
//                 color: CupertinoColors.systemRed,
//                 fontSize: 12,
//               ),
//               child: Text(widget.errorText!),
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
//
// class CustomCupertinoTextField extends CupertinoTextField {
//   final IconData prefixIcon;
//   final Function() onClearPressed;
//   final String? errorText;
//
//   CustomCupertinoTextField({
//     Key? key,
//     required TextEditingController controller,
//     required String placeholder,
//     required this.prefixIcon,
//     required this.onClearPressed,
//     this.errorText,
//   }) : super(
//     key: key,
//     controller: controller,
//     placeholder: placeholder,
//     prefix: Padding(
//       padding: const EdgeInsets.only(left: 8.0),
//       child: Icon(
//         prefixIcon,
//         color: CupertinoColors.systemGrey,
//         size: 28,
//       ),
//     ),
//     suffix: CupertinoButton(
//       onPressed: onClearPressed,
//       child: const Icon(
//         CupertinoIcons.clear_thick_circled,
//         size: 28,
//       ),
//     ),
//     suffixMode: OverlayVisibilityMode.editing,
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     decoration: BoxDecoration(
//       color: CupertinoColors.lightBackgroundGray,
//       borderRadius: BorderRadius.circular(8),
//     ),
//   );
// }

// import 'package:flutter/cupertino.dart';
//
// class CustomCupertinoTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String placeholder;
//   final IconData prefixIcon;
//   final Function() onClearPressed;
//   final String? errorText;
//   final String? Function(String?)? validator;
//
//   const CustomCupertinoTextField({
//     super.key,
//     required this.controller,
//     required this.placeholder,
//     required this.prefixIcon,
//     required this.onClearPressed,
//     this.errorText,
//     this.validator,
//   });
//   @override
//   CustomCupertinoTextFieldState createState() =>
//       CustomCupertinoTextFieldState();
// }
//
// class CustomCupertinoTextFieldState extends State<CustomCupertinoTextField> {
//   get value => widget.controller.value.text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CupertinoTextField(
//           placeholder: widget.placeholder,
//           controller: widget.controller,
//           obscureText: widget.placeholder == 'Password',
//           enableSuggestions: widget.placeholder != 'Password',
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: CupertinoColors.lightBackgroundGray,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           prefix: Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Icon(
//               widget.prefixIcon,
//               color: CupertinoColors.systemGrey,
//               size: 28,
//             ),
//           ),
//           suffix: CupertinoButton(
//             onPressed: widget.onClearPressed,
//             child: const Icon(
//               CupertinoIcons.clear_thick_circled,
//               size: 28,
//             ),
//           ),
//           suffixMode: OverlayVisibilityMode.editing,
//           onChanged: (value) {
//
//             setState(() {
//               widget.controller.text = value; // Update the controller value
//             });
//           },
//         ),
//         if (widget.errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(left: 16, top: 4),
//             child: DefaultTextStyle(
//               style: const TextStyle(
//                 color: CupertinoColors.systemRed,
//                 fontSize: 12,
//               ),
//               child: Text(widget.errorText!),
//             ),
//           ),
//       ],
//     );
//   }
// }

//
//
//
//
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class CustomCupertinoTextField extends CupertinoTextField {
// //   final Function() onClearPressed;
// //   final String? errorText; // New property for error messages
// //
// //   const CustomCupertinoTextField({
// //     super.key,
// //     required TextEditingController controller,
// //     required String placeholder,
// //     required IconData prefixIcon,
// //     required this.onClearPressed,
// //     this.errorText, // Initialize it with null by default
// //   }) : super(
// //           controller: controller,
// //           placeholder: placeholder,
// //           suffix: const CupertinoButton(
// //             onPressed: onClearPressed,
// //             child: Icon(
// //               CupertinoIcons.clear_thick_circled,
// //               size: 28,
// //             ),
// //           ),
// //           // prefix: Padding(
// //           //   padding: EdgeInsets.only(left: 8.0),
// //           //   child: Icon(
// //           //     prefixIcon,
// //           //     color: CupertinoColors.systemGrey,
// //           //     size: 28,
// //           //   ),
// //           // ),
// //         );
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         CupertinoTextField(
// //           placeholder: placeholder,
// //           controller: controller,
// //           obscureText: placeholder == 'Password',
// //           enableSuggestions: placeholder != 'Password',
// //           // prefix: Padding(
// //           //   padding: const EdgeInsets.only(left: 8.0),
// //           //   child: Icon(
// //           //     prefixIcon,
// //           //     color: CupertinoColors.systemGrey,
// //           //     size: 28,
// //           //   ),
// //           // ),
// //           suffix: CupertinoButton(
// //             onPressed: onClearPressed,
// //             child: const Icon(
// //               CupertinoIcons.clear_thick_circled,
// //               size: 28,
// //             ),
// //           ),
// //           suffixMode: OverlayVisibilityMode.editing,
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //           decoration: BoxDecoration(
// //             color: CupertinoColors.lightBackgroundGray,
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //         if (errorText != null)
// //           Padding(
// //             padding: const EdgeInsets.only(left: 16, top: 4),
// //             child: DefaultTextStyle(
// //               style: const TextStyle(
// //                 color: CupertinoColors.systemRed,
// //                 fontSize: 12,
// //               ),
// //               child: Text(errorText!),
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }
