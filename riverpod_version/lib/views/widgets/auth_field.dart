import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({super.key, required this.label, required this.icon,
    this.validator, this.keyboardType, this.obscure = false, this.suffix,
    this.maxLength, this.onChanged});
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? suffix;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
    validator: validator, keyboardType: keyboardType, obscureText: obscure,
    maxLength: maxLength, onChanged: onChanged,
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon),
      suffixIcon: suffix, counterText: ''),
  );
}
