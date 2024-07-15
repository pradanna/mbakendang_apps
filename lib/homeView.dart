import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbakendang/pesanView.dart';
import 'package:mbakendang/profileView.dart';


import 'controller/homeController.dart';
import 'historyView.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            Pesanview(),
            HistoryView(),
            ProfileView()
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        );
      }),

    );
  }
}
