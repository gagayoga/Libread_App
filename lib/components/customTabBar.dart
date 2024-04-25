import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatelessWidget {
  final String tittle;
  final Function() onTap;
  final int count;

  const CustomTabBar({
    super.key,
    required this.tittle,
    required this.onTap,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              tittle,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 14
              ),
            ),
          ),

          count > 0
          ? Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: Center(
              child: Text(
                count > 20 ? "20++" : count.toString(),
                style: GoogleFonts.inter(
                  color: const Color(0xFFFF0000),
                ),
              ),
            ),
          ) : const SizedBox(width: 0, height: 0,),
        ],
      ),
    );
  }
}
