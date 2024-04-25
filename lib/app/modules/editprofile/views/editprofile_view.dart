import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libread_ryan/components/customTextField.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends GetView<EditprofileController> {
  const EditprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightTopBar = MediaQuery.of(context).padding.top;
    double bodyHeight = height - heightTopBar;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: const Color(0xFF121212),
        titleSpacing: 0,
        title: Text(
          "Update Profile",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),
        iconTheme: const IconThemeData(color:Colors.white),
      ),
      body: Center(
        child: SafeArea(
          child: Container(
            width: width,
            height: bodyHeight,
            color: const Color(0xFF121212),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(child: kontenUpdateProfile(width)),
            ),
          ),
        ),
      ),
    );
  }

  Widget kontenUpdateProfile(double width){
    return Obx((){
      var dataProfile = controller.detailProfile.value;

      if(controller.detailProfile.value == null){
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF0000)),
            ),
          ),
        );
      }else{
        return Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                dataProfile!.username.toString(),
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
                dataProfile!.bio.toString(),
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              CustomTextField(
                controller: controller.namalengkapController,
                hinText: "Nama Lengkap",
                labelText: "Nama Lengkap",
                obsureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              CustomTextField(
                controller: controller.usernameController,
                hinText: "Username",
                labelText: "Username",
                obsureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              CustomTextField(
                controller: controller.emailController,
                hinText: "Email",
                labelText: "Email",
                obsureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              CustomTextField(
                controller: controller.bioController,
                hinText: "Bio",
                labelText: "Bio",
                obsureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              CustomTextField(
                controller: controller.teleponController,
                hinText: "Nomor Telepon",
                labelText: "Nomor Telepon",
                obsureText: false,
              ),

              const SizedBox(
                height: 50,
              ),

              SizedBox(
                width: width,
                height: 50,
                child: ElevatedButton(
                  onPressed: ()=> controller.updateProfilePost(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Obx(() => controller.loading.value?
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ): const Text(
                    "Update Profile",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
