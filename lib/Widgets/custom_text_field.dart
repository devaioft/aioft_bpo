import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.errorMessage,
    this.keyboardType,
    required this.readMode,      
    // this.initialValue,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final String? hintText;
  final String? errorMessage;
  // final String? initialValue;
  final TextInputType? keyboardType;
  final bool readMode;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      // initialValue: initialValue,
      style: readMode == true
          ? TextStyle(
              background: Paint(),
            )
          : null,
      readOnly: readMode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }
}
