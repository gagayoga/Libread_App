import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:libread_ryan/app/modules/buku/views/buku_view.dart';
import 'package:libread_ryan/app/modules/profile/views/profile_view.dart';
import 'package:libread_ryan/app/modules/searchbook/views/searchbook_view.dart';

import '../../../../components/customBarMaterial.dart';
import '../../home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget{
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
              body: Center(
                  child: IndexedStack(
                    index: controller.tabIndex,
                    children:  [
                      HomeView(),
                      SearchBookView(),
                      BukuView(),
                      ProfileView(),
                    ],
                  )
              ),
              bottomNavigationBar: Container(
                color: const Color(0xFF121212),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBottomBarMaterial(
                    onTap: controller.changeTabIndex,
                    currentIndex: controller.tabIndex,
                  ),
                ),
              )
          );
        }
    );
  }
}
