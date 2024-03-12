import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController  controller;
  final String hinText;
  final String labelText;
  final bool obsureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.labelText,
    required this.obsureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFFF0000);
    const Color focusColor = Color(0xFF44EAC2);
    const Color labelColor = Color(0xFF8A8586);

    return TextFormField(
      obscureText: obsureText,
      controller: controller,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: labelColor,
          fontWeight: FontWeight.w500,
        ),
        suffix: suffixIcon,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary.withOpacity(0.90),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: focusColor.withOpacity(0.90),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        hintText: hinText,
        hintStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      validator: validator,
    );
  }
}
