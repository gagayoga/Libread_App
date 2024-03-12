import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarMaterial extends StatelessWidget {

  final Color colorIcon = const Color(0xFF8C8787);
  final Color colorSelect = const Color(0xFFFFFFFF);
  final Color colorBackground = const Color(0xFF121212);
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorIcon= Color(0xFF121212);
    const Color colorSelect= Color(0xFFFFFFFF);
    const Color colorBackground= Color(0xFF989898);

    return BottomNavigationBar(
      unselectedItemColor: colorBackground,
      selectedItemColor: colorSelect,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorIcon,
      selectedFontSize: 14,
      selectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600
      ),
      iconSize: 24,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          icon: Icons.home_outlined,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Icons.search_outlined,
          label: 'Search',
        ),
        _bottomNavigationBarItem(
          icon: Icons.bookmark_outline,
          label: 'Bookmark',
        ),
        _bottomNavigationBarItem(
          icon: Icons.person_outlined,
          label: 'Profile',
        ),
      ],
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
