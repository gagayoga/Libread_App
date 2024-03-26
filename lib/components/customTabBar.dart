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
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF0000),
                fontSize: 18
              ),
            ),
          ),

          count > 0
          ? Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFFFF0000),
              shape: BoxShape.circle
            ),
            child: Center(
              child: Text(
                count > 20 ? "20++" : count.toString(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                ),
              ),
            ),
          ) : const SizedBox(width: 0, height: 0,),
        ],
      ),
    );
  }
}
