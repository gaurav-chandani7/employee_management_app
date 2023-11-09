import 'package:employee_management_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.onSaved,
      this.validator,
      this.onTap,
      this.readOnly = false,
      this.controller,
      this.initialValue,
      this.suffixIcon,
      this.textCapitalization = TextCapitalization.none});
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final String? initialValue;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      initialValue: initialValue,
      textCapitalization: textCapitalization,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Container(
              constraints: const BoxConstraints(
                  maxWidth: 30, maxHeight: 30, minWidth: 20, minHeight: 20),
              alignment: Alignment.center,
              child: prefixIcon),
          prefixIconColor: primaryColor,
          // prefixIconConstraints:
          //     const BoxConstraints(maxWidth: 30, maxHeight: 30),
          suffixIcon: suffixIcon,
          suffixIconColor: primaryColor),
    );
  }
}
