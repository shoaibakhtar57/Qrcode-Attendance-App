import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  AuthFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.label,
    required this.prefixIcon,
    required this.validator,
  }) : super(key: key);

  TextEditingController controller;
  String label;
  String hint;
  Icon prefixIcon;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder()),
    );
  }
}
