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
      this.initialValue});
  final String? hintText;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
