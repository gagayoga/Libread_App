import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libread_ryan/app/data/provider/storage_provider.dart';
import 'package:libread_ryan/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightTopBar = MediaQuery.of(context).padding.top;
    double bodyHeight = height - heightTopBar;

    String bio = StorageProvider.read(StorageKey.bio) ?? '-';

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            width: width,
            height: bodyHeight,
            color: const Color(0xFF121212),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [

                  const SizedBox(
                    height: 75,
                  ),

                  Image.asset(
                    'lib/assets/image/profile.png',
                    width: 100,
                    height: 100,
                    scale: 1 / 1,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    StorageProvider.read(StorageKey.username),
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    bio,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  kontenButton(
                      width,
                          (){
                        Get.toNamed(Routes.EDITPROFILE);
                      },
                      Icons.edit,
                      "Edit Profile"
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  kontenButton(
                      width,
                      (){

                      },Icons.bookmarks,"List"
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  kontenButton(
                      width,
                          (){

                      },Icons.history_rounded,"History"
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  kontenButton(
                      width,
                          (){
                        controller.logout();
                      },Icons.logout,"Sign Out"
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget kontenButton(double width,final onPressed,IconData iconButton, String namaButton){
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.80),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(
                iconButton,
                color: Colors.black,
                size: 25,
              ),

              const SizedBox(
                width: 10,
              ),

              Text(
                namaButton,
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
