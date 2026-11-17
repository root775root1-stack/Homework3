import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({super.key, required this.controller, required this.label, required this.icon, this.validator, this.keyboardType, this.obscureText = false, this.suffix, this.maxLength});
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final int? maxLength;
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller, validator: validator, keyboardType: keyboardType, obscureText: obscureText, maxLength: maxLength,
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon), suffixIcon: suffix, counterText: ''),
  );
}
