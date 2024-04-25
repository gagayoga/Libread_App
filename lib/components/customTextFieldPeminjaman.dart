import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldPeminjaman extends StatelessWidget {
  final bool obsureText;
  final String? InitialValue;
  final String labelText;
  final Widget? preficIcon;
  final Widget? surficeIcon;

  const CustomTextFieldPeminjaman({
    super.key,
    required this.obsureText,
    required this.InitialValue,
    required this.labelText,
    this.preficIcon,
    this.surficeIcon,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundInput = const Color(0xFF6B6565).withOpacity(0.20);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            labelText,
            style: GoogleFonts.inter(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),

          const SizedBox(
            height: 10,
          ),

          TextFormField(
            enabled: false,
            initialValue: InitialValue,
            obscureText: obsureText,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black.withOpacity(0.90),
            ),
            decoration: InputDecoration(
              prefixIcon: preficIcon,
                fillColor: backgroundInput,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.001,
                      color: Colors.grey.withOpacity(0.10),
                    ),
                    borderRadius: BorderRadius.circular(5.5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.001,
                      color: Colors.grey.withOpacity(0.10),
                    ),
                    borderRadius: BorderRadius.circular(5.5)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(5.5)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.001,
                      color: Colors.grey.withOpacity(0.10),
                    ),
                    borderRadius: BorderRadius.circular(5.5)),
                hintText: 'Masukan Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 5.0, horizontal: 10.0),
                hintStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withOpacity(0.50),
                )),
          ),
        ],
      ),
    );
  }
}
