//My previous try :)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhk_onboarding/components/text_field.dart';

class CustomCupertinoTextFormField extends FormField<String> {
  final TextEditingController controller;
  final String placeholder;
  final IconData prefixIcon;

  get value => controller.value.text;

  CustomCupertinoTextFormField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.prefixIcon,
    FormFieldValidator? validator,
  }) : super(
          initialValue: controller.text,
          validator: validator,
          builder: (state) {
            return CustomCupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              prefixIcon: prefixIcon,
              // errorText: state.errorText,
            );
          },
        );
}
